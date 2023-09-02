module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545, // Change this port if you are using ganache-cli, usually it's 8545 for the CLI version
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.1", // Change this to whatever version your contracts use
    },
  },
};
