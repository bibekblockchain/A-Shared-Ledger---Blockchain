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

    if [ -d "crypto-shrestha" ]; then
        rm -rf crypto-shrestha
    fi

    set -x
    cryptogen generate --config=./shrestha-retailer-crypto-config.yaml --output="crypto-shrestha"
    res=$?
    set +x

    if [ $res -ne 0 ]; then
        echo "Failed to generate certificates........!!!"
        exit 1
    fi
    echo
}

generateCertificates