pragma solidity ^0.4.17;

contract Dentist {
    address[] private clients;

    function newClient() public {
        clients.push(msg.sender);
    }

    function getAllClients() public view returns (address[]) {
        return clients;
    }

    function pay(uint amount) public payable {
        require(msg.value > 0.01 ether, "You must pay at least 0.01 ether");
    }

    function getBalance() view public returns (uint) {
        return this.balance;
    }
}
