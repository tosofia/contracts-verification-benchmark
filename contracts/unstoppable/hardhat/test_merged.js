const {
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
require("@nomicfoundation/hardhat-chai-matchers");

describe("Merged Unstoppable", function () {
  async function deployContract() {
    const [deployer, feeRecipient, user] = await ethers.getSigners();

    const DVT = await ethers.getContractFactory("DamnValuableToken");
    const dvt = await DVT.deploy();

    const UnstoppableVault = await ethers.getContractFactory("MergedUnstoppableVault");
    const vault = await UnstoppableVault.deploy(dvt.target, deployer.address, feeRecipient.address);

    //const FlashBorrower = await ethers.getContractFactory("UnstoppableMonitor");
    //const borrower = await FlashBorrower.connect(deployer).deploy(vault.target);

    return { deployer, dvt, feeRecipient, vault, user };
  }

  it("marged-unstoppable-vault: After a transaction with ERC20.trasfer to the vault, the vault stops", async function(){
    const { deployer, dvt, feeRecipient, vault, user} = await loadFixture(deployContract);

    const depositAmount = 5, userBalance = 10, flashloanAmount = 1;

    await dvt.connect(deployer).transfer(user.address, userBalance);

    await dvt.connect(user).approve(vault.target, depositAmount);
    await vault.connect(user).deposit(depositAmount, vault.target);
    

    expect(
      await vault.connect(deployer).checkFlashLoan(flashloanAmount)
    ).to.emit(vault, "FlashLoanStatus").withArgs(true);
    
    await dvt.connect(user).transfer(vault.target, 1);

    expect(
      await vault.connect(deployer).checkFlashLoan(flashloanAmount)
    ).to.emit(vault, "FlashLoanStatus").withArgs(true);
    

  })

});
