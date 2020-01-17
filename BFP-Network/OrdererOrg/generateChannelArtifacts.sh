#!/bin/bash
export FABRIC_CFG_PATH=${PWD}
CHANNEL_NAME=bfp-channel

function generateChannelArtifacts(){

    mkdir channel-artifacts
    
    which configtxgen
    if [ "$?" -ne 0 ]; then
        echo "Configtxgen tool not found. Exiting..."
        exit 1
    fi

    echo
    echo "#################################################"
    echo "##########.......Generating.........#############"
    echo "##########........Orderer...........#############"
    echo "##########........Genesis...........#############"
    echo "##########.........Block............#############"
    echo "#################################################"
    echo

    set -x
    configtxgen -profile BFPOrdererGenesis -channelID $CHANNEL_NAME -outputBlock ./channel-artifacts/genesis.block
    res=$?
    set +x

    if [ $res -ne 0 ]; then
        echo "Failed to generate genesis block configuration"
        exit 1
    fi
    echo
    echo "#################################################"
    echo "#####............Generating.................#####"
    echo "#####..............channel..................#####"
    echo "#####............configuration..............#####"
    echo "#####.............transaction...............#####"
    echo "#####.............(channel.tx)..............#####"
    echo "#################################################"
    echo

    set -x
    configtxgen -profile BFPChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
    res=$?
    set +x

    if [ $res -ne 0 ]; then
        echo "Failed to generate channel configuration"
        exit 1
    fi

    echo
    echo "#################################################################"
    echo "#######    Generating anchor peer update for KoiralaMSP   #######"
    echo "#################################################################"
    set -x
    configtxgen -profile BFPChannel -outputAnchorPeersUpdate ./channel-artifacts/KoiralaMSPanchors.tx -channelID $CHANNEL_NAME -asOrg KoiralaMSP
    res=$?
    set +x
    if [ $res -ne 0 ]; then
        echo "Failed to generate anchor peer update for Bank1MSP..."
        exit 1
    fi
    echo

    echo
    echo "#################################################################"
    echo "#######    Generating anchor peer update for ShresthaMSP   ######"
    echo "#################################################################"
    set -x
    configtxgen -profile BFPChannel -outputAnchorPeersUpdate ./channel-artifacts/ShresthaMSPanchors.tx -channelID $CHANNEL_NAME -asOrg ShresthaMSP
    res=$?
    set +x
    if [ $res -ne 0 ]; then
        echo "Failed to generate anchor peer update for ShresthaMSP..."
        exit 1
    fi
    echo
}

generateChannelArtifacts