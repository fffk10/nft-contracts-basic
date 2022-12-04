// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";

contract CounterNFT is ERC721URIStorage, Ownable {
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

    constructor() ERC721("CounterNFT", "COUNTER") {}

    function nftMint() public onlyOwner {
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
}
