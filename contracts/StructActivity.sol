// ===================================

// 1. Write a function that registers a new Educator into the smart contract given the struct parameters. Note also that the number of registered educator needs to be recorded.

// 2. Write a function that retrieves the data of an Educator given its name.

// ===================================

// SPDX-License-Identifier: Unlicense

pragma solidity >=0.6.0 <=0.8.0;

contract structActivity {
    // Declare Variables
    uint256 public counter;

    // Declare struct
    struct educator {
        uint256 id;
        string name;
        string course;
    }

    // Declare an array that can store educator data types and called educatorRecords 
    educator[] educatorRecords;

    // Constructor
    constructor() {
        counter = 0;
    }

    // Register an Educator
    // Declare a public function with parameters corresponding to educator struct
    // This function will create a new instance of educator and push it into the educatorRecords array
    // The counter will then be incremented
    function registerEducator(uint256 _id, string memory _name, string memory _course) public {

        // Check if the name does not already exist. We need to make sure a name is unique. If not, the transaction will revert.
        require (!educatorExists(_name), "Educator name already registered, please use another name.");

        // Create a new educator
        educator memory newEducator = educator(_id, _name, _course);
        
        educatorRecords.push(newEducator);
        counter++;
    }
 

    // Retrieve Data of an Educator given the Educator's Name
    function retrieveEducatorData(string memory _name) public view returns (uint256, string memory, string memory) {
        // Check the eductor name exists by calling the educator Exists function below. If not, the transaction will revert.
        require (educatorExists(_name), "Educator name does not exist, please try again.");

        // loop the educatorRecords array to find if the entered name corresponds to a registered educator
        for (uint256 i = 0; i < educatorRecords.length; i++) {
            if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(educatorRecords[i].name))) {
                return (educatorRecords[i].id, educatorRecords[i].name, educatorRecords[i].course);
            }
        }
    }

    // An internal function that checks whether the requested educator exists in the educatorRecords array
    function educatorExists(string memory _name) internal view returns (bool) {
        for (uint256 i = 0; i < educatorRecords.length; i++) {

            if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(educatorRecords[i].name))) {
                return true;
            }

        }
    }
}