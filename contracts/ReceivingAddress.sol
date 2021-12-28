// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ReceivingAddress {
    using SafeERC20 for IERC20;

    constructor (address tokenAddress) {
        if (tokenAddress != address(0)) {
            IERC20 token = IERC20(tokenAddress);
            token.safeTransfer(tx.origin, token.balanceOf(address(this)));
        }

        selfdestruct(payable(tx.origin));
    }
}