var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var Wallet = artifacts.require("./Wallet.sol");
var Contract = artifacts.require("./Contract.sol");
module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(Contract);
  deployer.link(Contract,Wallet);
  deployer.deploy(Wallet);
};
