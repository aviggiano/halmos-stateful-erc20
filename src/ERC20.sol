// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20 as OpenZeppelinERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20 is OpenZeppelinERC20, Ownable {
    constructor(string memory name, string memory symbol) OpenZeppelinERC20(name, symbol) Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public virtual onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public virtual onlyOwner {
        _burn(from, amount);
    }
}
