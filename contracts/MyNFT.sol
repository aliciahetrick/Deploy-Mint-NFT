//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// contains the implementation of the ERC-721 standard, which our NFT smart contract will inherit. (To be a valid NFT, your smart contract must implement all the methods of the ERC-721 standard.)
import "@openzeppelin/contracts/utils/Counters.sol";
// provides counters that can only be incremented or decremented by one. Our smart contract uses a counter to keep track of the total number of NFTs minted and set the unique ID on our new NFT. (Each NFT minted using a smart contract must be assigned a unique ID— here our unique ID is just determined by the total number of NFTs in existence. For example, the first NFT we mint with our smart contract has an ID of "1," our second NFT has an ID of "2," etc.)
import "@openzeppelin/contracts/access/Ownable.sol";
// sets up access control(opens in a new tab)↗ on our smart contract, so only the owner of the smart contract (you) can mint NFTs.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("MyNFT", "NFT") {}
    // The first variable is the smart contract’s name, and the second is its symbol

    function mintNFT(address recipient, string memory tokenURI)
    // address recipient specifies the address that will receive your freshly minted NFT
    // string memory tokenURI is a string that should resolve to a JSON document that describes the NFT's metadata
        public onlyOwner
        returns (uint256)
        // returns a number that represents the ID of the freshly minted NFT
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
