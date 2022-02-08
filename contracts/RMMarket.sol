//SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

// openzeppeling ERC721 NFT Functionality
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/ERC721/Counters.sol";

// security against transactions for multiple requests
import "hardhat/console.sol";

contract RMMarket is ReentrancyGuard {
    using Counters for Counters.Counter;

    /* numbers of items minting, number of transactions, tokens that have not been sold
     keep track of tokens total number - tokenId
     arrays need to know the length - help to keep track for arrays */

    Counters.Counter private _tokenIds;
    Counters.Counter private _tokensSold;

    // determine who is the owner of the contract
    // charge a listing fee so the owner makes a commission

    address payable owner;
    // we are deploying to matic the API is the same - same = ether
    // they both have 18 decimal
    // 0.045 is the cents
    uint256 listingPrice = 0.045 ether;

    constructor() {
        // set the owner
        owner = payable(msg.sender);
    }

    // structs can act like objects
    struct MarketToken {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    // tokenId return which MarketToken - fetch which one it is
    mapping(uint256 => MarketToken) private idToMarketToken;

    // listen to events from front end applications
    event MarketTokenMinted(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    // get the listing price
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    // two functions to interact with contract
    // 1. Create a market item to put it up for sale
    // 2. Create a market sale for buying and selling between parties

    function makeMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        // nonReentrant is a modifier to prevent reentry attack

        require(price > 0, "Price must be at least one wei");
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );

        _tokenIds.increment();
        uint256 itemId = _tokenIds.current();

        // Put it up for sale - bool - no owner
        idToMarketToken[itemId] = MarketToken(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        // NFT Transaction
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

        emit MarketTokenMinted(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price,
            false
        );
    }

    // Function to conduct transactions and market sales
    function createMarketSale(address nftContract, uint256 itemId)
        public
        payable
        nonReentrant
    {
        uint256 price = idToMarketToken[itemId].price;
        uint256 tokenId = idToMarketToken[itemId].tokenId;
        require(
            msg.value == price,
            "Please submit the asking price in order to continue"
        );

        // transfer the amount to the seller
        idToMarketToken[itemId].seller.transfer(msg.value);

        // transfer the token from contact address to the buyer
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);

        idToMarketToken[itemId].owner = payable(msdg.sender);
        idToMarketToken[itemId].sold = true;
        _tokensSold.increment();

        payable(owner).transfer(listingPrice);
    }

    // Function to fetchMarketItems - minting, buying and selling
    // Return the number of unsold items

    function fetchMarketTokens() public view returns (MarketToken[] memory) {
        uint256 itemCount = _tokenIds.current();
        uint256 unsoldItemsCount = _tokenIds.current() - _tokenSold.current();
        uint256 currentIndex = 0;

        // looping over the number of items created(if number has not been sold populate the array)
        MarketToken[] memory items = new MarketToken[](unsoldItemsCount);
        for (uint256 i = 0; i < itemsCount; i++) {
            if (idToMarketCount[i + 1].owner == address(0)) {
                uint256 currentId = i + 1;
                MarketToken storage currentItem = idToMarketToken[currentId];
                items[currentIndex] = currenItem;
                currentIdex += 1;
            }
        }
        return items;
    }

    function fetchMyNFTs() public view returns (MarketToken[] memory) {
        uint256 totalItemCount = _tokensIds.current();

        // a second counter for each individual user
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketToken[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }

        // Amount you have purchased with itemcount
        // Check to see if the owner address is equal to msg.sender
        MarkerToken[] memory items = new MarketToken[](itemCount);

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketToken[i + 1].owner == msg.sender) {
                uint256 currentId = idToMarketToken[i + 1].itemId;
                MarkerToken storage currentItem = idToMarketToken[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    // function for return an array of minted NFTs
    function fetchItemsCreated() public view returns (MarkerToken[] memory) {
        // instead of .owner it will be the .seller
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketToken[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        // Amount you have purchased with itemcount
        // Check to see if the seller address is equal to msg.sender
        MarkerToken[] memory items = new MarketToken[](itemCount);

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketToken[i + 1].seller == msg.sender) {
                uint256 currentId = idToMarketToken[i + 1].itemId;
                MarkerToken storage currentItem = idToMarketToken[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
