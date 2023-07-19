async function verifyContract(contract, constructorArgs) {
  // Check for supported networks
  const delay = (ms) => new Promise((res) => setTimeout(res, ms));
  console.log(`--- Verifying contract at ${contract.address} on etherscan`);
  await contract.deployed();
  await delay(60000); // 60 seconds
  await hre.run("verify:verify", {
    address: contract.address,
    constructorArguments: constructorArgs,
  });
  console.log(`--- Verification process ended\n\n`);
}

async function main() {
  const MyNFT = await ethers.getContractFactory("MyNFT");
  //   A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts, so MyNFT here is a factory for instances of our NFT contract. When using the hardhat-ethers plugin ContractFactory and Contract instances are connected to the first signer by default.

  // Start deployment, returning a promise that resolves to a contract object
  const myNFT = await MyNFT.deploy();
  //   Calling deploy() on a ContractFactory will start the deployment, and return a Promise that resolves to a Contract. This is the object that has a method for each of our smart contract functions.
  await myNFT.deployed();
  console.log("Contract deployed to address:", myNFT.address);

  await verifyContract(myNFT);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
