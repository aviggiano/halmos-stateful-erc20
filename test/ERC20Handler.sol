// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@src/ERC20.sol";
import {Vm} from "forge-std/Vm.sol";

contract ERC20Handler is ERC20 {
    address[] public targets;
    Vm public vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
    }

    function setTargets(address[] memory _targets) public onlyOwner {
        targets = _targets;
    }

    function mint(address to, uint256 amount) public override {
        vm.assume(_contains(targets, to));
        super.mint(to, amount);
    }

    function burn(address from, uint256 amount) public override {
        vm.assume(_contains(targets, from));
        _burn(from, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, to));
        return super.transfer(to, amount);
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, spender));
        return super.approve(spender, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        vm.assume(_contains(targets, from));
        vm.assume(_contains(targets, to));
        return super.transferFrom(from, to, amount);
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