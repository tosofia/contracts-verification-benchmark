  const {
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { expect } = require("chai");

  describe("Unstoppable", function () {
    async function deployContract() {
      const [deployer, feeRecipient, user] = await ethers.getSigners();

      const DVT = await ethers.getContractFactory("DamnValuableToken");
      const dvt = await DVT.deploy();

      const UnstoppableVault = await ethers.getContractFactory("UnstoppableVault");
      const vault = await UnstoppableVault.deploy(dvt.target, deployer.address, feeRecipient.address);

      const FlashBorrower = await ethers.getContractFactory("UnstoppableMonitor");
      const borrower = await FlashBorrower.connect(deployer).deploy(vault.target);

      await vault.connect(deployer).transferOwnership(borrower);

      return { deployer, dvt, feeRecipient, vault, borrower, user };
    }

    it("unstoppable-vault: After a transaction with ERC20.trasfer to the vault, the vault stops", async function(){
      const { deployer, dvt, feeRecipient, vault, borrower, user} = await loadFixture(deployContract);

      const depositAmount = 5, userBalance = 10, flashloanAmount = 1;

      await dvt.connect(deployer).transfer(user.address, userBalance);

      await dvt.connect(user).approve(vault.target, depositAmount);
      await vault.connect(user).deposit(depositAmount, vault.target);
      
      await expect(
        borrower.checkFlashLoan(flashloanAmount)
      ).to.emit(borrower, "FlashLoanStatus").withArgs(true);
      
      await dvt.connect(user).transfer(vault.target, 1);
      
      await expect(
        borrower.checkFlashLoan(flashloanAmount)
      ).to.emit(borrower, "FlashLoanStatus").withArgs(false);
      
    })

  });
