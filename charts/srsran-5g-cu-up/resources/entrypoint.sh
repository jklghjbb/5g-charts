#!/bin/bash

set -ex

if [ $# -lt 1 ]
then
        echo "Usage : $0 [cu]"
        exit
fi

if [[ -z "${UPF_BIND_ADDR}" ]] ; then
    export UPF_BIND_ADDR=$(ip addr show $UPF_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

if [[ -z "${NRU_BIND_ADDR}" ]] ; then
    export NRU_BIND_ADDR=$(ip addr show $NRU_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

envsubst < /cu-template.yml > cu-up.yml

/opt/srsRAN_Project/target/bin/srscu_up -c cu-up.yml