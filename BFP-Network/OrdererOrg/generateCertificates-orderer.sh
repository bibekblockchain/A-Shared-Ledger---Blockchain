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

    if [ -d "crypto-orderer" ]; then
        rm -rf crypto-orderer
    fi

    set -x
    cryptogen generate --config=./orderer-crypto-config.yaml --output="crypto-orderer"
    res=$?
    set +x

    if [ $res -ne 0 ]; then
        echo "Failed to generate certificates........!!!"
        exit 1
    fi
    echo
}

generateCertificates