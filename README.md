# The Rising Club - Music NFT Marketplace

NFT Community dedicated to rising musicians, artists, experts, and talented people all over the world.

### Running and Mint the App

```
npm build
npm run dev
npx hardhat node
Deploy contract: npx hardhat run scripts/deploy.js --network localhost
```

### Stack

- ethers: library to interact with the Ethereum blockchain network
- hardhat: development environment which allows to compile contracts
- @nomiclabs/hardhat-waffle:
- ethereum-waffle:
- chai: Js testing library
- @nomiclabs/hardhat-ethers:
- web3modal
- @openzeppelin/contracts: library that contains ERC-721 contracts
- ipfs-http-client: IPFS decentralized network to host our storages
- axios: HTTP Javascript

### Hardhat

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node:
node scripts/sample-script.js
npx hardhat help
```

Example of deployment of a smart contract using hardhat `npx hardhat run scripts/deploy.js --network localhost`.

```
web3_clientVersion
eth_chainId
eth_accounts
eth_blockNumber
eth_chainId (2)
eth_estimateGas
eth_getBlockByNumber
eth_feeHistory
eth_sendTransaction
  Contract deployment: RMMarket
  Contract address:    0x5fbdb2315678afecb367f032d93f642f64180aa3
  Transaction:         0x29377a7eb0d2c34d62182953b5946f4b1317086b548ea5afbd54349585c911a1
  From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
  Value:               0 ETH
  Gas used:            843253 of 843253
  Block #1:            0xa3aa89b1ef57b15ae15e1d00812b453dd02466963343bbceefface851196f5b2

eth_chainId
eth_getTransactionByHash
eth_chainId
eth_getTransactionReceipt
eth_accounts
eth_chainId
eth_estimateGas
eth_feeHistory
eth_sendTransaction
  Contract deployment: NFT
  Contract address:    0xe7f1725e7734ce288f8367e1bb143e90bb3f0512
  Transaction:         0x5adf6c1ebd68d93807bfb4f7db0acd4d459f2c964bed9f2b5d70eda23fd2640f
  From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
  Value:               0 ETH
  Gas used:            1394549 of 1394549
  Block #2:            0x1237140f953704da6d68103f6e0544dee68ce7fcd6030f29a790f5bddabc6dc0

eth_chainId
eth_getTransactionByHash
eth_chainId
eth_getTransactionReceipt
```
