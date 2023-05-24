/*
1. Contract was deployed to Goerli testnet on 24th of May 2023:

. Using Remix IDE (Injected Web3 / Metamask)

2. Contract address is: 0xeC922faffF3c1171dEcaC05efa1EAe75baf0dcf1

3. Contract is accessible here: https://goerli.etherscan.io/address/0xec922fafff3c1171decac05efa1eae75baf0dcf1

4. Contract was verified and published on Etherscan and it is possible to interact with it:

. Queries (to read) are available from here: https://goerli.etherscan.io/address/0xec922fafff3c1171decac05efa1eae75baf0dcf1#code
. Change to state variables can be done via Remix IDE

*/



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