// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        // _mint(msg.sender);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }
}
