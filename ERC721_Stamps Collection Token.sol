pragma solidity ^0.5.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.2.0/contracts/token/ERC721/ERC721Metadata.sol";

contract Stamps is ERC721Metadata 
{
    uint32 public Id;
    mapping(address => uint32) public MDTrack;
    
    constructor() 
        ERC721Metadata("Stamps Collection Token", "STAMP")  
        payable public {Id = 0;}
        
    //createNFT method
    function createNFT(address receiver, string calldata metadata) external returns (uint32)
    {
    Id++;
    _mint(receiver,Id);
    _setTokenURI(Id,metadata);
    MDTrack[receiver] = Id; 
    return Id;
    }
    
    //transferNFT method
    function transferNFT(address sender,address receiver, uint32 transId, string calldata metadata) external 
    {
    _transferFrom(sender, receiver, transId);
    _setTokenURI(transId,metadata);
    delete MDTrack[sender];
    MDTrack[receiver] = Id;
    }
}