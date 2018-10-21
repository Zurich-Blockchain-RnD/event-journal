/*
The idea was to write a smart contract that allows for a transaction between two parties, 
but with a trusted third party that verifies the identity of the parties and could step 
in as an arbitrator in case of disputes.
*/

pragma solidity ^0.4.24;

contract TransactionWithThirdParty {
    
    address thirdParty; //stores the address of the mediator
    address client; //stores the address of the client that pays for a service
    address serviceProvider; //stores the address of the paid service provider
    
    //you can store a list of addresses of service providers that are supported by a contract and limit the contract to work only with specific entities
    //in the same way, you can store a list of KYC'd clients that are allowed to use our contract
    
    //this code is part of a discussion on implementing a single service for payment transaction.
    constructor () public {
        thirdParty = msg.sender; //in this case, we see the uploader of the contract as the meditating third party
        //time delay for third party verrification can also be implemented
    }
    
    function calledByClient(bytes32 selectedService, address _serviceProvider) public returns(uint8){
        require(msg.sender != thirdParty); //this blocks the mediator from also using the contract as the client because then he can store a dispute in his favor
        //of course, the mediator can still create the contract with one account (account as in private key) and become a client with a different account
        //to circumvent such an attack we can either bind the mediator by law or create a maybe to complex mechanism
        client = msg.sender; //set the client as the service consumer
        serviceProvider = _serviceProvider; //set the client according to a parameter possibly by someone else (like the service provider)
        if(/*service provided*/ true) { //this is just another sketch of an idea to perform the payment under certain conditions to pay or during the initiation of the contract
            //pay service provider
        }
        return 0;
    }
    function payServiceProvider(address serviceProviderToPay) { //a separate function that could be limited for example to the mediator to conclude the transaction
        if(/*service provided*/ true) {
            //pay service provider
        }
    }
}
