// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CrowdfundingAssignmentUnic {

    constructor() {
    }

    // Declare Project as a struct datatype
    struct Project {
        uint256 projectID;
        string projectTitle;
        // string projectDescription;
        address projectOwner;
        uint256 projectParticipationAmount; // a specific amount that each user is required to contribute when participating in the project
        uint256 projectTotalFundingAmount;
        // uint256 projectFundingGoal; 
    }

    // Declare a projects mapping filled with all the Projects (with Project datatype)
    mapping(uint256 => Project) private projects;
    // maps from project IDs to a mapping of user addresses to participation amounts
    mapping(uint256 => mapping(address => uint256)) private participation;

    // A variable that will be used to assign project IDs automatically
    // We may also use some external library to assign a unic ID for each Project
    uint nextProjectID = 1;

    // Implement a setter function where project owners can list a project
    function createProject(string memory _projectTitle, uint256 _projectParticipationAmount) public {
        // Need to make sure that the user files out the necessary data (in particular that it is not empty)
        // require(checkProjectID[_projectID] == false);
        Project memory newProject = Project(nextProjectID, _projectTitle, msg.sender, _projectParticipationAmount, 0); // projectOwner will be assigned the address of the sender of the transaction
        projects[nextProjectID] = newProject;
        nextProjectID++;
    }

    function getProjectDetails(uint256 _projectID) public view returns (uint256, string memory, address, uint256, uint256) {
        // return projects[_projectID];
        Project storage project = projects[_projectID];
        return (project.projectID, project.projectTitle, project.projectOwner, project.projectParticipationAmount, project.projectTotalFundingAmount);
        
        // revert("Project not found.");
        // Implement an error management system to inform the User that the _projectID does not exist
    }

    // A payable setter function called participateToProject(), where users can interact with the smart contract to fund a specific project
    // When a user contributes to a project, the smart contract should record the user's address, project ID, and the amount of their participation.
    function participateToProject(uint256 _projectID) public payable {

        uint _participationAmount = msg.value;
        
        // retrieve the Project struct with the specific projectID from the projects mapping, and assign it to the project storage variable
        Project storage project = projects[_projectID];

        require(_participationAmount == project.projectParticipationAmount, "Participation amount is not correct.");

        project.projectTotalFundingAmount += _participationAmount;
        participation[_projectID][msg.sender] += _participationAmount;
        payable(address(this)).transfer(_participationAmount);
    }


    // A getter function named retrieveContributions(), which allows users to retrieve the contributions made by a specific Ethereum address to a specific project.
    // The user needs to input the Ethereum address and the projectID to retrieve the relevant information.
    function retrieveContributions(uint256 _projectID, address _user) public view returns (uint) {
        // Project storage project = projects[_projectID];
        return participation[_projectID][_user];
    }

    // A withdrawal function, named withdrawFunds(), that can only be called by the project owner of the respective project. 
    // When called, this function should transfer the current projectTotalFundingAmount of the specific project to the project owner's wallet.
    function withdrawFunds(uint _projectID) public payable {
        Project storage project = projects[_projectID];
        require(msg.sender == project.projectOwner, "You must be the project Owner to withdraw the funds.");
        address payable _to = payable(project.projectOwner);
        _to.transfer(project.projectTotalFundingAmount);
    }


    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}


// ================================
// ACTION ITEMS
// ================================



// TO DO - Make sure the withdrawn funds can only be withdrawn once (there should be a deduction on the projectTotalFundingAmount

// TO DO - Add some restriction to the parameters that can be entered by the user

// TO DO - Make sure the Project Owner can only transfer to its account in case the fundingGoal is not reached

// TO DO (maybe later version) - In case the fundingGoal is not reached at a specific date then the funds will be automatically returned to Users

// TO DO - Make sure a User can only get back its contribution once

// TO DO - Apply some fees to account for the gas a the returned amount cannot be equal

