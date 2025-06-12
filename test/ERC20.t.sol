// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20Handler} from "@test/ERC20Handler.sol";
import {Test} from "forge-std/Test.sol";

contract ERC20Test is Test {
    ERC20Handler public erc20;
    address[3] public users = [
      address(0x10000),
      address(0x20000),
      address(0x30000)
    ];
    address[] public targets;

    uint256 public constant INITIAL_BALANCE = 100e18;

    function setUp() public {
        for (uint256 i = 0; i < users.length; i++) {
            targets.push(users[i]);
        }
        targets.push(address(this));
        targets.push(address(0));


        erc20 = new ERC20Handler("Token", "TKN");
        targets.push(address(erc20));

        erc20.setTargets(targets);

        for (uint256 i = 0; i < users.length; i++) {
            erc20.mint(users[i], INITIAL_BALANCE);
            targetSender(users[i]);
        }
        targetContract(address(erc20));
    }

    function invariant_sum_balanceOf_eq_totalSupply() public view {
        uint256 totalBalance = 0;
        for (uint256 i = 0; i < targets.length; i++) {
            totalBalance += erc20.balanceOf(targets[i]);
        }
        assertEq(totalBalance, erc20.totalSupply());
    }
}