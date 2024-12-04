// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract MagicSwapFaucet {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    function doManyTradesAndProfitStonks(
        address emulatedTokenAddress,
        uint256 tokensThatWouldBeConsumed,
        uint256 emulatedProfit
    ) public {
        require(
            emulatedProfit > tokensThatWouldBeConsumed,
            "This operation is not profitable"
        );
        require(
            IERC20(emulatedTokenAddress).balanceOf(address(this)) >=
            emulatedProfit - tokensThatWouldBeConsumed,
            "Trying to profit more than what this contract holds of balance"
        );
        IERC20(emulatedTokenAddress).transferFrom(
            msg.sender,
            address(this),
            tokensThatWouldBeConsumed
        );
        IERC20(emulatedTokenAddress).approve(msg.sender, emulatedProfit);
    }
}
