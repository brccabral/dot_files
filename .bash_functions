function nip() {
    _print_network_info() {
        # return if ${1} is empty
        if [ -z ${1} ]; then
            return
        fi
        network_inspect=$(docker network inspect --format "{{.Name}}""\
,{{range .IPAM.Config}}{{.Subnet}}{{end}}""\
,{{range .IPAM.Config}}{{if (index . \"Gateway\")}}{{.Gateway}}{{end}}{{end}}""\
,{{slice .Id 0 12}}" \
            "${1}")
        echo $network_inspect >>/tmp/docker-network.txt
    }

    echo "------------------------------------------------------"
    echo "NETWORK,SUBNETS,GATEWAYS,ID" >/tmp/docker-network.txt

    if [ -z "${1}" ]; then
        # if ${1} is empty, print all networks
        docker network ls --format "{{.ID}}" | while read -r network_id; do
            _print_network_info "$network_id"
        done
    else
        # print all networks that ID or Name starts with ${1}
        docker network ls --format "{{.ID}} {{.Name}}" | awk "/^${1}| ${1}/ {print \$1}" | while read -r network_id; do
            _print_network_info "$network_id"
        done
    fi

    column -s "," --output-separator " ┊ " -t /tmp/docker-network.txt
    echo "------------------------------------------------------"

    rm -r /tmp/docker-network.txt

}

function cip() {
    _print_container_info() {
        # return if ${1} is empty
        if [ -z ${1} ]; then
            return
        fi

        # {{range .NetworkSettings.Networks}}{{.MacAddress}} {{end}}
        # {{range .NetworkSettings.Networks}}{{.GlobalIPv6Address}} {{end}}
        # {{range .NetworkSettings.Networks}}{{.IPv6Gateway}} {{end}}
        container_inspect=$(docker container inspect --format="{{slice .Name 1}}""\
,{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}""\
,{{range .NetworkSettings.Networks}}{{.Gateway}} {{end}}""\
,{{range \$p, \$conf := .NetworkSettings.Ports}}{{if \$conf}}{{if ne (index \$conf 0).HostIp \"0.0.0.0\"}}{{(index \$conf 0).HostIp}}:{{end}}{{(index \$conf 0).HostPort}}{{else}}null{{end}}:{{\$p}} {{end}}""\
,{{range \$k, \$v := .NetworkSettings.Networks}}{{\$k}} {{end}}""\
,{{slice .Id 0 12}}" \
            "${1}")

        echo $container_inspect >>/tmp/docker-container.txt
    }

    echo '------------------------------------------------------'
    # echo 'CONTAINER,IP,Gateway,Mac,IPv6,IPv6 Gateway,PORTS,Networks,ID' >/tmp/docker-container.txt
    echo 'CONTAINER,IP,Gateway,PORTS,Networks,ID' >/tmp/docker-container.txt

    all_flag=""
    if [ "${1}" = "-all" ]; then
        all_flag="-a"
        container_search=$2
    else
        container_search=$1
    fi
    if [ -z "${1}" ]; then
        # if ${1} is empty, print all containers
        docker ps -q | while read -r container_id; do
            _print_container_info "$container_id"
        done
    else
        # print all containers that ID or Name starts with ${1}
        docker container ls $all_flag --format "{{.ID}} {{.Names}}" | awk "/^${container_search}| ${container_search}/ {print \$1}" | while read -r container_id; do
            _print_container_info "$container_id"
        done
    fi

    column -s "," --output-separator " ┊ " -t /tmp/docker-container.txt
    echo '------------------------------------------------------'

    rm -r /tmp/docker-container.txt

}

function dexec() {
    if [ -z $2 ]; then
        docker exec -it $1 /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"
    else
        docker exec -u $1 -it $2 /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"
    fi
}

function dlogs() {
    if [ -z $2 ]; then
        docker logs -fn 10 $1
    else
        docker logs -fn $1 $2
    fi
}

# prints previous healthcheck messages
function dhealth() {
    if [ -z $1 ]; then
        echo "Need a docker ID or Name"
        return 1
    fi
    container_search=$1
    docker container ls $all_flag --format "{{.ID}} {{.Names}}" | awk "/^${container_search}| ${container_search}/ {print \$1}" | while read -r container_id; do
        docker inspect -f '{{json .State.Health}}' "$container_id" | jq
    done
}
