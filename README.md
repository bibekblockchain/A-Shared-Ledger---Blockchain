# A Shared Ledger - Blockchain

This is the guide regarding how to setup the environment and see the shared ledger which we discussed on our article "A Shared Ledger - Blockchain" of Blockchain for Professionals

> Make sure you have all the [pre-requisities]([https://hyperledger-fabric.readthedocs.io/en/release-1.4/getting_started.html](https://hyperledger-fabric.readthedocs.io/en/release-1.4/getting_started.html)) installed for running a Fabric environment before proceeding further. You can setup your environment by looking into the Hyperledger official documentation.

## Step 1: Cloning the repository

You can clone this repository. But I suggest you to fork it first, so that you can play around with it.

## Step 2: Generating the certificates

Make sure you are inside the BFP-Network directory since most of the network setup will be done inside the directory

Generating artifacts for ``Koirala_Suppliers``

```

cd Koirala_Suppliers

./generateCertificates-koirala-suppliers.sh

```

Similarly generate artifacts for ``OrdererOrg and Shrestha_Retailer``

## Step 3: Generating the channel artifacts

All the channel activities are maintained by the OrdererOrg therefore make sure you are inside it when you perform the following commands

```

cd BFP-Network/OrdererOrg/

./generateChannelArtifacts.sh

```

## Step 4: Getting the network up

startNetwork.sh script runs all the necessary commands required to get the network up and running.

If you have already created the artifacts and just want to get the network running, use script as 
``./startNetwork.sh``

> Note: If you are running this script for the first time after you have created the certificates and artifacts then you need to create the docker-compose yaml files from their template and the way to do that is by ``./startNetwork.sh replace``


## Step 5: Install and instantiate the chaincode
To install, instantiate and invoke the chaincode, run injectChaincode.sh script
``./injectChaincode.sh``

## Step 6: Visualizing the Ledger
  
Now you can look at your browser in [Koirala Supplier's Ledger](http://localhost:5984/_utils) and [Shrestha Retailer's Ledger](http://localhost:7984/_utils) to see the shared ledger between Koirala Suppliers and Shrestha Retailer.
