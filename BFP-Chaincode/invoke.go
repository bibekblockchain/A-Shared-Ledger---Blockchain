package main

import (
	"encoding/json"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

//function to prepare bills

func prepareBill(stub shim.ChaincodeStubInterface, args []string) pb.Response {

	if len(args) != 1 {
		return shim.Error("Invalid argument count\n")
	}

	partial := struct {
		UUID string `json:"billUUID"`
	}{}
	bill := bill{}

	errp := json.Unmarshal([]byte(args[0]), &partial)
	if errp != nil {
		return shim.Error(errp.Error())
	}

	errf := json.Unmarshal([]byte(args[0]), &bill)
	if errf != nil {
		return shim.Error(errf.Error())
	}

	if partial.UUID == "" {
		return shim.Error("Expected UUID for the bill")
	}

	billKey, err := stub.CreateCompositeKey("Bill", []string{partial.UUID})
	if err != nil {
		return shim.Error(err.Error())
	}

	billAsBytes, err := json.Marshal(bill)
	if err != nil {
		return shim.Error("Error marshaling bill structure")
	}

	err = stub.PutState(billKey, billAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}
	
	return shim.Success(billAsBytes)
}






