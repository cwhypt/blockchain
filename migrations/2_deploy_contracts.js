var Wallet = artifacts.require("./Wallet.sol");
var Channel = artifacts.require("./Channel.sol");
module.exports = function(deployer) {
  deployer.deploy(Channel);
  deployer.link(Channel,Wallet);
  deployer.deploy(Wallet);
};
