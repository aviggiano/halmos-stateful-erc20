// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20 as OpenZeppelinERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20Buggy is OpenZeppelinERC20, Ownable {
    uint256 public constant MAX_UPDATES_BEFORE_BUG = 5;

    uint256 public updateCounter;

    constructor(string memory name, string memory symbol) OpenZeppelinERC20(name, symbol) Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public virtual onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public virtual onlyOwner {
        _burn(from, amount);
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return updateCounter < MAX_UPDATES_BEFORE_BUG ? super.balanceOf(account) : 0;
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        updateCounter++;
        super._update(from, to, value);
    }
}
