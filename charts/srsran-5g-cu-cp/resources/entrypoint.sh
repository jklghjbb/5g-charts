#!/bin/bash

set -ex

if [ $# -lt 1 ]
then
        echo "Usage : $0 [cu-cp]"
        exit
fi

if [[ ! -z "$AMF_HOSTNAME" ]] ; then 
    export AMF_ADDR="$(host -4 $AMF_HOSTNAME |awk '/has.*address/{print $NF; exit}')"
fi

if [[ -z "${AMF_BIND_ADDR}" ]] ; then
    export AMF_BIND_ADDR=$(ip addr show $AMF_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

if [[ -z "${F1AP_BIND_ADDR}" ]] ; then
    export F1AP_BIND_ADDR=$(ip addr show $F1AP_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

if [[ -z "${E1AP_BIND_ADDR}" ]] ; then
    export E1AP_BIND_ADDR=$(ip addr show $E1AP_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

envsubst < /cu-template.yml > cu_cp.yml

/opt/srsRAN_Project/target/bin/srscu_cp -c cu_cp.yml