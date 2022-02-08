const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RMMarket", function () {
  it("Should mint and trade NFTs", async function () {
    // test to receive contract addresses
    const Market = await ethers.getContractFactory('RMMarket')
    const market = await Market.deploy()
    await market.deployed()
    const marketAddress = market.address

    const NFT = await ethers.getContractFactory('NFT')
    const nft = await NFT.deploy(marketAddress)
    await nft.deployed()
    const nftContactAddress = nft.address

    // test to receive listing price and auction price
    let listingPrice = await market.getListingPrice()
    listingPrice = listingPrice.toString()

    const auctionPrice = ethers.util.parseUnit('100', 'ether')
    
    // test for mint
    await nft.mintToken('https-t1')
    await nft.mintToken('https-t2')

    await market.makeMarkertItem(nftContactAddress, 1, auctionPrice, {value: listingPrice})
    await market.makeMarkertItem(nftContactAddress, 2, auctionPrice, {value: listingPrice})
  
    // test for different addresses from different users - test accounts
    // return an array of however many addresses
    const [_, buyerAddress] = await ethers.getSigners()

    // create a market sale with address, id and price
    await market.connect(buyerAddress).createMarketSale(nftContractAddress, 1, {
      value: auctionPrice
    })

    const items = await market.fetchMarketTokens()

    // test out all the items
    console.log('items', items)
  });
});
