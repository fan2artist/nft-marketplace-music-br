import { ethers } from 'ethers'
import { useEffect, useState } from 'react'
import axios from 'axios'
import Web3Modal from 'web3modal'

import { nftaddress, nftmarketaddress } from '../config'

import NFT from '../artifacts/contracts/NFT.sol/NFT.json'
import RMMarket from '../artifacts/contracts/RMMarket.sol/RMMarket.json'

export default function Home() {
  const [nfts, setNFTs] = useState([])
  const [loadingState, setLoadingState] = useState('not loaded')

  useEffect(() => {
    loadNFTs()
  }, [])

  async function loadNFTs() {
    // What we want to load: 
    // provider, tokenContract, marketContrat, data for our marketItems

    console.log(nftaddress);
    console.log(nftmarketaddress);
    console.log(NFT.abi);
    const provider = new ethers.providers.JsonRpcProvider()
    const tokenContract = new ethers.Contract(nftaddress, NFT.abi, provider)
    const marketContract = new ethers.Contract(nftmarketaddress, RMMarket.abi, provider)
    const data = await marketContract.fetchMarketItems()

    const items = await Promise.all(data.map(async i => {
      const tokenUri = await tokenContract.tokenURI(i.tokenId)
      
      // Get the token metadata - json
      const meta = await axios.get(tokenUri)
      let price = ethers.utils.formatUnits(i.price.toString(), 'ether')
      let item = {
        price,
        tokenId: i.tokenId.toNumber(),
        seller: i.seller,
        owner: i.owner,
        image: meta.data.image,
        name: meta.data.description
      }
      return item    
    }))
    setNFTs(items)
    setLoadingState('loaded')
  }

  return (
    <div>
      The Rising Club - Music NFT Marketplace
    </div>
  )
}