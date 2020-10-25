pragma solidity ^0.5.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.2.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.2.0/contracts/token/ERC20/ERC20Capped.sol"; 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.2.0/contracts/ownership/Ownable.sol";

contract MagicCoin is ERC20Detailed, ERC20Capped, Ownable {
    constructor()
        ERC20Detailed("Magic Coin: used to purchase for any games in DisneyLand Parks", "MAGIC", 4)
        ERC20Capped(10000000000) 
        payable public {}
}