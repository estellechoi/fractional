// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

// a token which has a NFT locked in and has fractional ownership of it
contract Fractional is ERC20, Ownable {
    uint256 public sharePrice; // 1 SKSS
    uint256 public shareSupply; // 100

    uint256 public nftTokenId;
    IERC721 public nft;
    IERC20 public skss;

    uint256 public balance = 0;

    constructor(
        string memory _name,
        string memory _symbol,
        address _nftAddress,
        uint256 _nftTokenId,
        uint256 _sharePrice,
        uint256 _shareSupply,
        address _skssAddress
    ) ERC20(_name, _symbol) {
        nftTokenId = _nftTokenId;
        nft = IERC721(_nftAddress);
        sharePrice = _sharePrice;
        shareSupply = _shareSupply;
        skss = IERC20(_skssAddress);
    }

    function stakeNFT() external onlyOwner {
        // transfer NFT #1 from sender to this contract
        nft.transferFrom(msg.sender, address(this), nftTokenId);
    }

    // follow ChecksEffectsInteractions pattern
    // _shareAmt must be in wei
    function buyShare(uint256 _shareAmt) external {
        // Checks
        //totalSupply() returns the amount of already shared tokens
        require(totalSupply() + _shareAmt <= shareSupply, "Over");

        uint256 skssAmt = _shareAmt * sharePrice;

        // Effects
        _mint(msg.sender, _shareAmt);
        balance += skssAmt;

        // Interactions
        // transfer skss coins from sender to this contract
        skss.transferFrom(msg.sender, address(this), skssAmt);
    }

    function withdrawBalance() external onlyOwner {
        skss.transferFrom(address(this), msg.sender, balance);
    }
}
