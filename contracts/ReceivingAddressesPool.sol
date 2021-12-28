// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Create2.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract ReceivingAddressesPool is Ownable {
    using Address for address;

    function raiseFunds(
        bytes32[] memory salts,
        bytes memory receivingAddressBytecode
    ) public onlyOwner {
        for (uint256 index = 0; index < salts.length; index++) {
            Create2.deploy(0, salts[index], receivingAddressBytecode);
        }
    }

    function balancesOf (address[] memory accounts, address tokenAddress) public view returns (uint256[] memory) {
        uint256[] memory balances = new uint256[](accounts.length);
        
        if (tokenAddress == address(0)) {
            for (uint256 index = 0; index < accounts.length; index++) {
                balances[index] = accounts[index].balance;
            }
        } else if (tokenAddress.isContract()) {
            IERC20 token = IERC20(tokenAddress);
            for (uint256 index = 0; index < accounts.length; index++) {
                balances[index] = token.balanceOf(accounts[index]);
            }
        }

        return balances;
    }
}
