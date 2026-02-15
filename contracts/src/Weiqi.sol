// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


/**
* @title Weiqi
* @author @YashIngle21
* @notice This contract is the main contract for the Weiqi game
*/


import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {GameCoin} from "./GameCoin.sol";



contract Weiqi is Ownable, ReentrancyGuard {

    error MinDepositNotMet(uint256 depositedAmount);
    error InsufficientBalance(address  player, uint256 requestedAmount);
    error CashOutFailed();



    uint256 public constant EXCHANGE_RATE = 1000; // 1000 weiqi tokens per 1 ETH
    uint256 public constant MIN_DEPOSIT = 0.01 ether; // Minimum deposit amount

    mapping(address => uint256) public gameCoinBalances;

    GameCoin public gameCoin;

    event GameCoinBought(address indexed buyer, uint256 amount);


    constructor(address initialOwner) Ownable(initialOwner) {
        gameCoin = new GameCoin(address(this));
    }


    // Game Coin Purchase and Cash Out

    /*
    * @notice Buys game coins for the caller
    * @dev Emits a GameCoinBought event
    * @param msg.value The amount of ETH to buy game coins for
     */

    function buyToken() external payable {
        if(msg.value <= MIN_DEPOSIT) {
            revert MinDepositNotMet(msg.value);
        }
        gameCoin.mint(msg.sender, msg.value * EXCHANGE_RATE);
        emit GameCoinBought(msg.sender, msg.value * EXCHANGE_RATE);

    }

    /**
    * @notice Cashes out game coins for the caller
    * @dev Emits a GameCoinBought event
    * @param amount The amount of game coins to cash out
    */

    function cashOut(uint256 amount) external payable {
        if(gameCoin.balanceOf(msg.sender) < amount){
            revert InsufficientBalance(msg.sender, amount);
        }
        gameCoin.burn(msg.sender, amount);
        uint256 amountInEth = amount / EXCHANGE_RATE;
        (bool success,) = msg.sender.call{value: amountInEth}("");
        if(!success){
            revert CashOutFailed();
        }
    }

    // Game Functions( HappyPath)

    function startGame( address opponentAddress, uint256 depositAmount, uint80 gameId, bytes calldata opponentSignature) external{
        if(depositAmount < gameCoinBalances[msg.sender]){
            revert InsufficientBalance(msg.sender, depositAmount);
        }



    }

    function settleGame(uint80 gameId, address winnerAddress, uint256 totalPotSpent, bytes[] calldata signatures) external {}


    // Dispute Resolution Functions


    function initiateTimeout(uint80 gameId, address lastsignedSatate) external {}

    function claimTimeout(uint80 gameId) external {}

    function _resolveDispute(uint80 gameId, bytes calldata newestSignedState) internal{}


    receive() external payable {}

    fallback() external payable {}
}
