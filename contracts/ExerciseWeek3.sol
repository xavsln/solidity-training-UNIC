// SPDX-License-Identifier: Unlicence

pragma solidity >=0.6.0 <0.8.0;

contract ExerciseWeek3 {

    uint256 number;
    string word;

    constructor(uint _number, string memory _word) {
        number = _number;
        word = _word;
    }

    function changeAttributes(uint256 _number, string memory _word) public returns(bool) {
        number = _number;
        word = _word;
        return true; // Can be used to indicate the caller that the function executed successfully
    }

    function getAttributes() public view returns(uint, string memory) {
        return (number, word);
    }

}