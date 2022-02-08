require("@nomiclabs/hardhat-waffle");

const projectId = '';
const fs = require('fs');
const accountKeyData = fs.readFileSync('./p-key.txt', {
  encoding: 'utf-8', flag: 'r'
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      chainId: 1337 // config standard
    },
    mumbai: {
      url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
      accounts: [accountKeyData]
    },
    mainnet: { 
      url: `https://mainnet.infura.io/v3/${projectId}`,
      accounts: [accountKeyData]
    }
  },
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};
