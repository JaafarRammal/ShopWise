pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract SupplyChain {
    address owner;

    struct TraceEntry {
        address seller_address;
        string origin;
        string seller;
        string role;
        string transport;
        uint256 carbon_footprint;
    }

    struct Trace {
        uint256 id;
        TraceEntry[] steps;
    }


    Trace[100] public products ;
    uint256 public productLength = 0;

    function getProducts() public view returns( Trace[100] memory) {
        return products;
    }

    function getProduct(uint256 _id) public view returns (Trace memory ){
        for (uint256 i = 0; i < productLength; ++i) {
            if(products[i].id == _id) {
                return products[i];
            }
        }
    }

    function transfer(uint256 _id, string memory _origin, string memory _seller, string memory _role, string memory _transport, uint256 _carbon_footprint) public {
        for (uint256 i = 0; i < products.length; ++i) {
            if(products[i].id == _id) {
                products[i].steps.push(TraceEntry(msg.sender, _origin, _seller, _role, _transport, _carbon_footprint));
                return;
            }
        }
        Trace storage trace = products[productLength];
        productLength++;
        trace.id = _id;
        trace.steps.push(TraceEntry(msg.sender, _origin, _seller, _role, _transport, _carbon_footprint));
    }

    constructor() public {
        owner = msg.sender;
    }

}