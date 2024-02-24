function nip() {
    _print_network_info() {
        local network_search
        local network_name
        local network_id
        local network_gatewayIPv4
        local network_subnetIPv4
        local network_gatewayIPv6
        local network_subnetIPv6
        network_search="${1}"

        network_name="$(docker network inspect --format "{{.Name}}" "$network_search" | sed 's/\///')"
        network_id="$(docker network inspect --format "{{.ID}}" "$network_search")"
        network_subnetIPv4="$(docker network inspect $network_search | jq '.[].IPAM.Config[0].Subnet')"
        network_gatewayIPv4="$(docker network inspect $network_search | jq '.[].IPAM.Config[0].Gateway')"
        network_subnetIPv6="$(docker network inspect $network_search | jq '.[].IPAM.Config[1].Subnet')"
        network_gatewayIPv6="$(docker network inspect $network_search | jq '.[].IPAM.Config[1].Gateway')"

        # echo ''$network_name','$network_subnetIPv4','$network_gatewayIPv4','$network_subnetIPv6','$network_gatewayIPv6','${network_id:0:6}'' >>~/tmp/docker-network.txt
        echo ''$network_name','$network_subnetIPv4','$network_gatewayIPv4','${network_id:0:6}'' >>~/tmp/docker-network.txt
    }

    touch ~/tmp/docker-network.txt
    echo '------------------------------------------------------'
    # echo 'NETWORK,SUBNET IPv4,GATEWAY IPv4,SUBNET IPv6,GATEWAY IPv6,ID' >>~/tmp/docker-network.txt
    echo 'NETWORK,SUBNET IPv4,GATEWAY IPv4,ID' >>~/tmp/docker-network.txt

    local network_search
    network_search="$1"
    if [ -z "$network_search" ]; then
        # if $network_search is empty
        docker network ls --format "{{.ID}}" | while read -r network_search; do
            _print_network_info "$network_search"
        done
    else
        # only calls _print_network_info if $network_search exits
        docker network ls --format "{{.ID}} {{.Name}}" | grep -q "\b$network_search\b" && _print_network_info "$network_search"
    fi

    column -s "," --output-separator " ┊ " -t ~/tmp/docker-network.txt
    echo '------------------------------------------------------'

    rm -r ~/tmp/docker-network.txt

}

function cip() {
    _print_container_info() {
        local container_search
        local container_id
        local container_ports
        local container_ip
        local container_gateway
        local container_ipv6
        local container_ipv6_gateway
        local container_name
        local container_mac
        local container_network
        container_search="${1}"

        container_ports=($(docker port "$container_search" | grep -o ":[0-9]\+" | cut -f2 -d:))
        container_name="$(docker container inspect --format "{{.Name}}" "$container_search" | sed 's/\///')"
        container_id="$(docker container inspect --format "{{.ID}}" "$container_search")"
        container_ip="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}" "$container_search")"
        container_gateway="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.Gateway}} {{end}}" "$container_search")"
        container_mac="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.MacAddress}} {{end}}" "$container_search")"
        container_ipv6="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.GlobalIPv6Address}} {{end}}" "$container_search")"
        container_ipv6_gateway="$(docker container inspect --format "{{range .NetworkSettings.Networks}}{{.IPv6Gateway}} {{end}}" "$container_search")"
        container_network=($(docker container inspect --format "{{range \$k, \$v := .NetworkSettings.Networks}}{{printf \"%s\n\" \$k}}{{end}}" "$container_search"))

        # echo ''$container_name','$container_ip','$container_gateway','$container_mac','$container_ipv6','$container_ipv6_gateway','${container_ports[*]}','${container_network[*]}','${container_id:0:6}'' >>~/tmp/docker-container.txt
        echo ''$container_name','$container_ip','$container_gateway','${container_ports[*]}','${container_network[*]}','${container_id:0:6}'' >>~/tmp/docker-container.txt
    }

    touch ~/tmp/docker-container.txt
    echo '------------------------------------------------------'
    # echo 'CONTAINER,IP,Gateway,Mac,IPv6,IPv6 Gateway,PORTS,Networks,ID' >>~/tmp/docker-container.txt
    echo 'CONTAINER,IP,Gateway,PORTS,Networks,ID' >>~/tmp/docker-container.txt

    local container_search
    container_search="$1"
    if [ -z "$container_search" ]; then
        # if $container_search is empty
        docker ps -a --format "{{.ID}}" | while read -r container_search; do
            _print_container_info "$container_search"
        done
    else
        # only calls _print_container_info if $container_search exits
        docker container ls --format "{{.ID}} {{.Names}}" | grep -q "\b$container_search\b" && _print_container_info "$container_search"
    fi

    column -s "," --output-separator " ┊ " -t ~/tmp/docker-container.txt
    echo '------------------------------------------------------'

    rm -r ~/tmp/docker-container.txt

}
