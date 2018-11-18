var wallet = artifacts.require("./Wallet.sol");

contract('wallet', function(accounts) {
  it("should set up channelUser for the first account", function() {
    return wallet.deployed().then(function(instance) {
      return instance.getValue.call(accounts[0],{from: account[0]});
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 100, "10000 wasn't in the first account");
    });
  });
  
});
