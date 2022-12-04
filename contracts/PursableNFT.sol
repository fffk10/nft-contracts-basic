// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";

contract PursableNFT is
    ERC721URIStorage,
    ERC721Burnable,
    ERC721Pausable,
    Ownable
{
    /**
     * @dev
     * - _tokenIdsはCounters.Counterの全関数を使用可能
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /**
     * @dev
     * - URI設定時に誰がどのtokenIdに何のURIを設定したか記録する
     */
    event TokenURIChanged(
        address indexed sender,
        uint256 indexed tokenId,
        string uri
    );

    constructor() ERC721("BurnableNFT", "BURN") {}

    function nftMint() public onlyOwner whenNotPaused {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(_msgSender(), newTokenId);

        // 文字列結合
        string memory jsonFile = string(
            abi.encodePacked("metadata", Strings.toString(newTokenId), ".json")
        );

        _setTokenURI(newTokenId, jsonFile);
        emit TokenURIChanged(_msgSender(), newTokenId, jsonFile);
    }

    /**
     * @notice  .
     * @dev     IPFS URI prefix
     */
    function _baseURI() internal pure override returns (string memory) {
        return
            "ipfs://bafybeigyod7ldrnytkzrw45gw2tjksdct6qaxnsc7jdihegpnk2kskpt7a/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev     処理自体はERC721のもの
     */
    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
