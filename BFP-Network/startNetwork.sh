#!/bin/bash
CURRENT_DIR=$PWD
CHANNEL_NAME=bfp-channel
export IMAGE_TAG=latest
export COMPOSE_PROJECT_NAME=bfp

function replacePrivateKeys(){
    cd "$CURRENT_DIR"
    cd Koirala_Suppliers/crypto-koirala/peerOrganizations/koirala.bfp.com/ca/
    PRIV_KEY=$(ls *_sk)
    cd "$CURRENT_DIR"
    cd Koirala_Suppliers/
    cp docker-compose-koirala-suppliers-template.yaml docker-compose-koirala-suppliers.yaml
    sed -i "s/CA_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-koirala-suppliers.yaml

    cd "$CURRENT_DIR"
    cd Shrestha_Retailer/crypto-shrestha/peerOrganizations/shrestha.bfp.com/ca/
    PRIV_KEY=$(ls *_sk)
    cd "$CURRENT_DIR"
    cd Shrestha_Retailer/
    cp docker-compose-shrestha-retailer-template.yaml docker-compose-shrestha-retailer.yaml
    sed -i "s/CA_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-shrestha-retailer.yaml
}

function networkUp(){
    cd "$CURRENT_DIR"
    cd OrdererOrg/
    docker-compose -f docker-compose-orderer.yaml up -d
    cd "$CURRENT_DIR"
    cd Koirala_Suppliers/
    docker-compose -f docker-compose-koirala-suppliers.yaml up -d
    cd "$CURRENT_DIR"
    cd Shrestha_Retailer/
    docker-compose -f docker-compose-shrestha-retailer.yaml up -d
}

function createAndJoinChannel(){
    docker exec koirala-cli peer channel join -b channel-artifacts/genesis.block
    docker exec shrestha-cli peer channel join -b channel-artifacts/genesis.block
}

if [ "$1" == "replace" ]; then
    echo "Replacing the values in docker-compose file with the regenerated files value"
    replacePrivateKeys
fi

networkUp
sleep 10

#check if channel is already created. If not create and join peers to it

OUTPUT=$(docker exec koirala-cli peer channel list | grep $CHANNEL_NAME)

if [ -z "$OUTPUT" ]; then
    createAndJoinChannel
fi