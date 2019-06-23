const Fighters = artifacts.require("FightGame");

module.exports = function (deployer) {
  deployer.deploy(Fighters);
};
