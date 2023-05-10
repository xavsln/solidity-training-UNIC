// Instructions:

// Write a function that lets a user to claim a certain amount of tokens by calling the claimTokens() function. Please take into consideration the following:

// the user can only claim the tokens only one (1) time 
// after the claim the user's balance gets updated.


// SPDX-License-Identifier: Unlicense

pragma solidity >=0.6.0 <=0.8.0;

contract mappingActivity {

    // Declare Variables
    uint256 public counter;
    mapping (address => uint256) public balanceOf;

    // Function to claim tokens
    function claimTokens() public {
        // Declare the amount of tokens the user is allowed to claim
        uint256 allowedAmount = 2 * 10**18;

        // Make sure the counter is still set to 0 otherwise the contract execution will be reverted
        require(counter == 0, "The user can only claim the tokens one (1) time");

        // Increase the number of tokens held by the user (add the allowedAmount to the user balance in the mapping)
        balanceOf[msg.sender] += allowedAmount;
        counter++; // Increment the counter by 1
    }

    // Function that checks the user amount of token (to see whether it was updated)
    function checkAccountMappingAmount() public view returns(uint256) {
        return balanceOf[msg.sender];
    }
}