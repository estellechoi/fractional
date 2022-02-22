// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SunkissCoin is ERC20 {
    constructor() ERC20("SunkissCoin", "SunkissCoin") {}

    // amount must be in wei (ETH * 10¹⁸)
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
