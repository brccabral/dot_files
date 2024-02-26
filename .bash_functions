function nip() {
    _print_network_info() {
        # return if ${1} is empty
        if [ -z ${1} ]; then
            return
        fi
        network_name="$(docker network inspect --format "{{.Name}}" "${1}" | sed 's/\///')"
        network_id="$(docker network inspect --format "{{.ID}}" "${1}")"
        network_subnets="$(docker network inspect --format "{{range .IPAM.Config}}{{.Subnet}}{{end}}" "${1}")"
        network_gateways="$(docker network inspect --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}" "${1}")"

        echo "$network_name","$network_subnets","$network_gateways","${network_id:0:12}" >>/tmp/docker-network.txt
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
        container_ports="$(docker container inspect --format='{{range $p, $conf := .NetworkSettings.Ports}}{{if $conf}}{{if ne (index $conf 0).HostIp "0.0.0.0"}}{{(index $conf 0).HostIp}}:{{end}}{{(index $conf 0).HostPort}}{{else}}null{{end}}:{{$p}} {{end}}' "${1}")"
        container_name="$(docker container inspect --format "{{.Name}}" "${1}" | sed 's/\///')"
        container_id="$(docker container inspect --format "{{.ID}}" "${1}")"
        container_ip="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}" "${1}")"
        container_gateway="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.Gateway}} {{end}}" "${1}")"
        container_mac="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.MacAddress}} {{end}}" "${1}")"
        container_ipv6="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.GlobalIPv6Address}} {{end}}" "${1}")"
        container_ipv6_gateway="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.IPv6Gateway}} {{end}}" "${1}")"
        container_network=($(docker container inspect --format "{{range \$k, \$v := .NetworkSettings.Networks}}{{printf \"%s\n\" \$k}}{{end}}" "${1}"))

        # echo ''$container_name','$container_ip','$container_gateway','$container_mac','$container_ipv6','$container_ipv6_gateway','${container_ports[*]}','${container_network[*]}','${container_id:0:12}'' >>/tmp/docker-container.txt
        echo ''$container_name','$container_ip','$container_gateway','$container_ports','${container_network[*]}','${container_id:0:12}'' >>/tmp/docker-container.txt
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
