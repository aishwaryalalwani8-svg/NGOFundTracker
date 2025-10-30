// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NGOFundTracker {
    address public ngoOwner;
    uint256 public totalFunds;

    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    Donation[] public donations;

    constructor() {
        ngoOwner = msg.sender;
    }

    // Function 1: Accept donations
    function donate() external payable {
        require(msg.value > 0, "Donation must be greater than 0");
        donations.push(Donation(msg.sender, msg.value, block.timestamp));
        totalFunds += msg.value;
    }

    // Function 2: Withdraw funds (only NGO owner)
    function withdraw(uint256 amount) external {
        require(msg.sender == ngoOwner, "Only NGO owner can withdraw");
        require(amount <= address(this).balance, "Insufficient balance");
        payable(ngoOwner).transfer(amount);
    }

    // Function 3: View all donations (transparency)
    function getAllDonations() external view returns (Donation[] memory) {
        return donations;
    }
}
