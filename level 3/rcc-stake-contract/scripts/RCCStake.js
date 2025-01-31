const { ethers, upgrades } = require("hardhat");
const hre = require("hardhat"); // 添加这一行

async function main() {
  //  部署获取到的Rcc Token 地址
  const RccToken = "0x4e6b80590D0dE4fB318a6D175E5292FE056004eA"; // 质押起始区块高度,可以去sepolia上面读取最新的区块高度
  const startBlock = 7559577; // 质押结束的区块高度,sepolia 出块时间是12s,想要质押合约运行x秒,那么endBlock = startBlock+x/12
  const endBlock = 9529999; // 每个区块奖励的Rcc token的数量
  const RccPerBlock = "20000000000000000";
  const Stake = await hre.ethers.getContractFactory("RCCStake");
  console.log("Deploying RCCStake...");
  const s = await upgrades.deployProxy(
    Stake,
    [RccToken, startBlock, endBlock, RccPerBlock],
    { initializer: "initialize" }
  ); //await box.deployed();
  console.log("Box deployed to:", await s.getAddress());
}

main();
