// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@src/ERC20.sol";
import {ERC20Buggy} from "@src/ERC20Buggy.sol";
import {Handler} from "@test/Handler.sol";
import {Test} from "forge-std/Test.sol";

contract ERC20Test is Test {
    Handler[] public handlers;
    address[3] public users = [address(0x10000), address(0x20000), address(0x30000)];
    address[] public targets;

    uint256 public constant INITIAL_BALANCE = 100e18;

    function setUp() public {
        for (uint256 i = 0; i < users.length; i++) {
            targets.push(users[i]);
        }
        targets.push(address(this));
        targets.push(address(0));

        ERC20 erc20 = new ERC20("Token", "TKN");
        ERC20Buggy erc20Buggy = new ERC20Buggy("TokenBuggy", "TKNBUG");

        handlers.push(new Handler(erc20, targets));
        handlers.push(new Handler(erc20Buggy, targets));

        for (uint256 i = 0; i < users.length; i++) {
            erc20.mint(users[i], INITIAL_BALANCE);
            erc20Buggy.mint(users[i], INITIAL_BALANCE);
            targetSender(users[i]);
        }
        for (uint256 i = 0; i < handlers.length; i++) {
            targetContract(address(handlers[i]));
        }
    }

    /// @custom:halmos --invariant-depth 10 --loop 10
    function invariant_sum_balanceOf_eq_totalSupply() public view {
        for (uint256 i = 0; i < handlers.length; i++) {
            uint256 sumBalanceOf = 0;
            for (uint256 j = 0; j < targets.length; j++) {
                sumBalanceOf += handlers[i].balanceOf(targets[j]);
            }
            assertEq(sumBalanceOf, handlers[i].totalSupply());
        }
    }
}
