pragma solidity ^0.6.0;

contract SupplyChain {
    address owner;
    string public origin;
    string public destination;
    string public seller;
    string public role;
    string public transport;

    constructor(string memory _origin, string memory _destination, string memory _seller, string memory _role, string memory _transport) public {
        origin = _origin;
        destination = _destination;
        seller = _seller;
        role = _role;
        transport = _transport;
        owner = msg.sender;
    }
}