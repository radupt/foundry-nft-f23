    // SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    // ERC721 from openzeppelin
    uint256 private s_tokenCouter;
    mapping(uint256 => string) private s_tokenIdToUri; //will took a tokenId and give a token Uri

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCouter = 0; // rappresents each tokenID, for each NFT "Dogie", (maybe are 10, eachone has his own tokenID)
    }

    function mintNft(string memory tokenUri) public {
        // chose how image will look like
        s_tokenIdToUri[s_tokenCouter] = tokenUri;

        // function _safeMinf from ERC721
        _safeMint(msg.sender, s_tokenCouter); // mint = coniare
        s_tokenCouter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // override the tokenURI of ERC721

        return s_tokenIdToUri[tokenId]; //https:// dfdfdfd = centralized website        ipfs://dsd = this points to the ipfs network which is a distributed decentralized network
    }
}
