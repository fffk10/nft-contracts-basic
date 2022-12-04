// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    address public owner;

    constructor() ERC721("MyNFT", "MYNFT") {
        owner = _msgSender();
    }

    // このままだとNFTのMintを誰でも行うことができる
    function nftMint(address _to, uint256 _tokenId) public {
        _mint(_to, _tokenId);
    }
}
