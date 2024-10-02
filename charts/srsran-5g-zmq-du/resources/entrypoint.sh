#!/bin/bash

set -ex

if [ $# -lt 1 ]
then
        echo "Usage : $0 [du]"
        exit
fi

if [[ -z "${F1AP_BIND_ADDR}" ]] ; then
    export F1AP_BIND_ADDR=$(ip addr show $F1AP_BIND_INTERFACE | grep -Po 'inet \K[\d.]+')
fi

envsubst < /du-template.yml > du.yml


/opt/srsRAN_Project/target/bin/srsdu -c du.yml 