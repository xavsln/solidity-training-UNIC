// SPDX-License-Identifier: Unlicense

pragma solidity >=0.6.0 <0.8.0;

contract Week4Exercises {
    uint[] public numArray;

    constructor() {
        numArray = [2,62,10,33,12,9];
    }

    // Function that returns the whole numArray
    function returnArray() public view returns(uint256[] memory) {
        return numArray;
    }
    
    // Function that finds the max number that exists within the array
    function findMax() public view returns(uint256) {
        // Declare maxValue and i (will be used as a counter in the Loop) variables
        uint256 maxValue = 0;
        uint8 i;

        // Create a loop that will check the max value of an array
        for (i = 0; i < numArray.length; i++) {
            if (numArray[i] > maxValue) {
                maxValue = numArray[i];
            } 
        }
        return maxValue;
    }
    
    // Function that removes an element from the array given an index position
    function removeElement(uint256 _index) public returns (uint[] memory){
        // Create a variable used as a counter in the loop
        uint i;

        // Set up an error handling function require that will return a message in case the entered index is outside of the numArray
        require(_index <= numArray.length-1, "Incorrect value entered, please try again.");

        // Re-order the items of the array after the item to be removed
        for (i = _index; i < numArray.length-1; i++) {
            numArray[i] = numArray[i+1];
        }

        // Remove the last element from the numArray
        numArray.pop();

        // Return the updated numArray to check the result is as expected
        return numArray;
    }
}