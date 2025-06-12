// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Vm} from "forge-std/Vm.sol";

contract Handler is IERC20 {
    IERC20 public erc20;
    address[] public targets;
    Vm public vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    constructor(IERC20 _erc20, address[] memory _targets) {
        erc20 = _erc20;
        targets = _targets;
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, to));
        vm.prank(msg.sender);
        return erc20.transfer(to, amount);
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, spender));
        vm.prank(msg.sender);
        return erc20.approve(spender, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, from));
        vm.assume(_contains(targets, to));
        vm.prank(msg.sender);
        return erc20.transferFrom(from, to, amount);
    }

    function balanceOf(address account) public view override returns (uint256) {
        return erc20.balanceOf(account);
    }

    function totalSupply() public view override returns (uint256) {
        return erc20.totalSupply();
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return erc20.allowance(owner, spender);
    }

    function _contains(address[] storage array, address value) internal view returns (bool) {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }
}
