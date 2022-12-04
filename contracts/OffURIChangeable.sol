// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract OffURIChangeable is ERC721URIStorage, Ownable {
    constructor() ERC721("OffURIChangeable", "OFFC") {}

    function nftMint(uint256 tokenId) public onlyOwner {
        _mint(_msgSender(), tokenId);
    }

    /**
     * @notice  .
     * @dev     既存のトークンIDにURIを紐付け
     * @param   tokenId  既存のトークンID
     * @param   uri  紐づけるURI
     */
    function setTokenId(uint256 tokenId, string calldata uri) public onlyOwner {
        _setTokenURI(tokenId, uri);
    }
}
