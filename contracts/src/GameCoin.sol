// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
* @title GameCoin
* @author @YashIngle21
* @notice This contract is the main contract for the GameCoin token
*/

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GameCoin is ERC20 {
    constructor(address initialOwner) ERC20("GameCoin", "GAME") {}

    function mint(address to, uint256 amount) external{
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external{
        _burn(from, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool){
        return super.transfer(to, amount);
        
    }

    function approve(address spender, uint256 amount) public override returns (bool){
        return super.approve(spender, amount);
    }

}