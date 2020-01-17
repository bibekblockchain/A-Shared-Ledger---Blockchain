#!/bin/bash

function generateCertificates(){
    which cryptogen

    if [ "$?" -ne 0 ]; then
    echo "cryptogen tool not found. exiting"
    exit 1
    fi

    echo
    echo "###########...............................................##############"
    echo "###########.....|||||||||||||||||||||||||||||||||||.......##############"
    echo "###########.....||    Generating certificates    ||.......##############"
    echo "###########.....|||||||||||||||||||||||||||||||||||.......##############"
    echo "###########...............................................##############"
    echo

    if [ -d "crypto-koirala" ]; then
        rm -rf crypto-koirala
    fi

    set -x
    cryptogen generate --config=./koirala-suppliers-crypto-config.yaml --output="crypto-koirala"
    res=$?
    set +x

    if [ $res -ne 0 ]; then
        echo "Failed to generate certificates........!!!"
        exit 1
    fi
    echo
}

generateCertificates
