// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {

const [deployer] = await ethers.getSigners();
console.log('Deploying contracts with the account: ${deployer.address}');

const balance = await deployer.getBalance();
console.log('Account Balance: ${balance.toString()}');

const VolcanoCoin = await hre.ethers.getContractFactory("VolcanoCoin");
const volcanoCoin = await VolcanoCoin.deploy();

console.log("Token deployed to:", volcanoCoin.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
