/*
Mockup exam in the frame of UNIC BLOC522 (Smart Contract Programming) Final Examination preparation

1. Write a function namely, registerStudent() - which uses the structure to register a new user into the smart contract.
2. Write a function namely, retrieveUser() - which retrieves the data of a registered user given its id.

*/


//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

contract structExample {
    
    struct dAppUser {
        uint256 id;
        string name;
        address userAddress;
        }

    dAppUser[] public dUser;

    constructor() {
    }

    // Register User
    function registerUser(uint256 _id, string memory _name, address _userAddress) public {
        dAppUser memory newUser = dAppUser(_id, _name, _userAddress);
        dUser.push(newUser);
    }

    // Retrieve Data (by ID)
    function retrieveUser(uint256 _id) public view returns (uint256, string memory, address) {
        uint256 index;
        for (uint256 i = 0; i < dUser.length; i++) {
            if (dUser[i].id == _id) {
                index = i;
                break;
            }
        }
        return (dUser[index].id, dUser[index].name, dUser[index].userAddress);
    }

}
