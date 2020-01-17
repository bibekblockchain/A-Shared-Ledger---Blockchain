CHANNEL_NAME="bfp-channel"

function installChaincode(){
    docker exec koirala-cli peer chaincode install -n BFP-Chaincode -v ${VERSION} -p github.com/chaincode/
    docker exec shrestha-cli peer chaincode install -n BFP-Chaincode -v ${VERSION} -p github.com/chaincode/
}

function instantiateChaincode(){
    docker exec koirala-cli peer chaincode instantiate -o orderer.bfp.com:7050 -C $CHANNEL_NAME -n BFP-Chaincode -v ${VERSION} -c '{"Args":["init"]}'
}

echo -n "Enter the version of the chaincode"
read VERSION

echo "Installing chaincode in peers"
installChaincode
echo "Instantiating chaincode in channel"
instantiateChaincode
sleep 10
docker exec koirala-cli peer chaincode invoke -C bfp-channel -n BFP-Chaincode -o orderer.bfp.com:7050 -c '{"Args":["prepare_bill","{\"billUUID\":\"001\",\"shippedGoods\":[{\"name\":\"Acer-E5\",\"description\":\"1 TB Hard Disk\", \"quantity\":\"10 pieces\", \"price\":700000}],\"totalPrice\": 750000}"]}'
echo "Please check in localhost:5984/_utils and localhost:7984/_utils to see the shared ledger"