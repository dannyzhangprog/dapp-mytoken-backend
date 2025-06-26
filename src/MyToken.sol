// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    event Minted(uint256 amount);
    event Burned(uint256 amount);

    constructor(address initialOwner) ERC20("MyToken", "MTK") Ownable(initialOwner) {}

    function mint(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
        emit Minted(amount);
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
        emit Burned(amount);
    }
}
