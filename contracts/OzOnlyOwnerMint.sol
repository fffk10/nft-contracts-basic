// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";

/**
 * @author  fffk10
 * @title   コントラクトのオーナーのみが作成できるNFT
 * @dev     オーナー以外はNFTを作成できないコントラクト
 * @notice  .
 */
contract OzOnlyOwnerMint is ERC721, Ownable {
    constructor() ERC721("OzOnlyOnlyOwnerMint", "OZNER") {}

    /**
     * @notice  .
     * @dev
     * - このコントラクトをデプロイしたアドレスだけがmint可能 onlyOwner
     * - nftMint関数の実行アドレスにtokenIdを紐付け
     * @param   _tokenId  トークンID
     */
    function nftMint(uint256 _tokenId) public onlyOwner {
        _mint(_msgSender(), _tokenId);
    }

    function fail() external pure {
        require(false, "FAILED HERE");
    }
}
