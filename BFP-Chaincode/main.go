package main

 import (
	 "fmt"
 
	 "github.com/hyperledger/fabric/core/chaincode/shim"
	 pb "github.com/hyperledger/fabric/protos/peer"
 )
 
 var logger = shim.NewLogger("main")
 
 // BFPChaincode implementation
 type BFPChaincode struct {
	 testMode bool
 }
 
 //Init implementation
 func (t *BFPChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
 
	 var err error
	 fmt.Println("Initializing BFP")
	 _, args := stub.GetFunctionAndParameters()
 
	 if len(args) != 0 {
		 err = fmt.Errorf("No arguments expected but found %d", len(args))
		 return shim.Error(err.Error())
	 }
	 return shim.Success(nil)
 }
 
 // Invoke Function
 func (t *BFPChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {

	 function, args := stub.GetFunctionAndParameters()
 
	 if function == "init" {
		 return t.Init(stub)
	 }

	switch function {
	case "prepare_bill":
		return prepareBill(stub, args)
	default:
		return shim.Error("Invalid function invoked!!")
	}
 }

 func main() {
	 logger.SetLevel(shim.LogInfo)
	 
	 twc := new(BFPChaincode)
	 twc.testMode = false
	 err := shim.Start(twc)
	 if err != nil {
		 fmt.Printf("Error starting BFP chaincode: %s", err)
	 }
 }