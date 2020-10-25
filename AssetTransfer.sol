pragma solidity ^0.5.2;

contract AssetTransfer {
    
    string public assetName;
    uint public orderCount;
    uint public assetPrice;
    uint public transportFee;
    
    mapping(uint=>address) public buyer;
    mapping(uint=>address payable) public seller;
    mapping(uint=>address payable) public transporter;
    enum orderstatus {CREATED, PURCHASED, IN_TRANSIT, DELIVERED, FINALIZED}
    mapping(uint=>orderstatus) public status;
    
    constructor(string memory _assetName, uint _assetPrice, uint _transportFee) public {
        assetName = _assetName;
        assetPrice = _assetPrice * 1 ether;
        transportFee = _transportFee * 1 ether;
        orderCount = 0;
    }
    
    function createOrder(uint orderNum) public {
        orderCount ++;
        seller[orderNum] = msg.sender;
        status[orderNum] = orderstatus.CREATED;
    }
    
    function buyAsset(uint orderNum) public payable {
        require(status[orderNum] == orderstatus.CREATED && msg.value == assetPrice + transportFee);
        buyer[orderNum] = msg.sender;
        status[orderNum] = orderstatus.PURCHASED;
    }
   
   function transportAsset(uint orderNum) public {
       require(status[orderNum] == orderstatus.PURCHASED);
       transporter[orderNum] = msg.sender;
       status[orderNum] = orderstatus.IN_TRANSIT;
   }
   
   function deliverAsset(uint orderNum) public {
       require(msg.sender == transporter[orderNum] && status[orderNum] == orderstatus.IN_TRANSIT);
       status[orderNum] = orderstatus.DELIVERED;
   }
   
   function acceptDelivery(uint orderNum) public {
       require(msg.sender == buyer[orderNum] && status[orderNum] == orderstatus.DELIVERED);
       seller[orderNum].transfer(assetPrice);
       transporter[orderNum].transfer(transportFee);
       status[orderNum] = orderstatus.FINALIZED;
   }
}