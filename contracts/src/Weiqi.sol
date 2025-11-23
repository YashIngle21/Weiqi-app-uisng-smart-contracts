// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract Weiqi {

    function buyToken() external payable {}

    function cashOut(uint256 amount) external {}

    function startGame( address opponentAddress, uint256 depositAmount, uint80 gameId, bytes calldata opponentSignature) external{}

    function settleGame(uint80 gameId, address winnerAddress, uint256 totalPotSpent, bytes[] calldata signatures) external {}

    function initiateTimeout(uint80 gameId, address lastsignedSatate) external {}

    function claimTimeout(uint80 gameId) external {}

    function resolveDispute(uint80 gameId, bytes calldata newestSignedState) external {}
}
