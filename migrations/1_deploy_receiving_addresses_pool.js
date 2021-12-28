var ReceivingAddressesPool = artifacts.require("./ReceivingAddressesPool.sol");

module.exports = function(deployer) {
  deployer.deploy(ReceivingAddressesPool);
};
