var wallet = artifacts.require("./Wallet.sol");

contract('wallet', function(accounts) {
  it("should set up channelUser for the first account", function() {
	  var wal;
    return wallet.deployed().then(function(instance) {
	  wal=instance;
      return wal.getValue.call(accounts[0],{from: accounts[0]});
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 100, "100 wasn't in the first account");
	  return wal.getValue.call(accounts[1]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 0, "0 wasn't in the second account or undefined");
    });
  });
  

  it("Start two and three account", function() {
    var wal;

    return wallet.deployed().then(function(instance) {
      wal = instance;
      return wal.initiateUser({from: accounts[1]});
    }).then(function() {
      wal.initiateUser({from: accounts[2]});
	  return wal.getValue.call(accounts[1]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 10,"Initialized incorrectly");
    });
  });  
  
    it("Open channel between zero and one", function() {
    var wal;

    return wallet.deployed().then(function(instance) {
      wal = instance;
      return wal.openChannel(accounts[1],1000,'gasPay',{from: accounts[0]});
    }).then(function(string) {
      assert.equal(string.valueOf(), 'name',"Initialized incorrectly");
    });
  });  
  
  
  
});
