// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";

/**
 * @author  fffk10
 * @title   コントラクトのオーナーのみが作成できるNFT
 * @dev     オーナー以外はNFTを作成できないコントラクト
 * @notice  .
 */
contract OnlyOwnerMinWithModifier is ERC721 {
    /**
     * @dev
     * - このコントラクトをデプロイしたアドレス用変数owner
     */
    address public owner;

    constructor() ERC721("OnlyOwnerMinWithModifier", "OWNERMOD") {
        owner = _msgSender();
    }

    /**
     * @dev このコントラクトをデプロイしたアドレスのみに制御する
     */
    modifier onlyOwner() {
        require(owner == _msgSender(), "Caller is not the owner");
        _;
    }

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
}
