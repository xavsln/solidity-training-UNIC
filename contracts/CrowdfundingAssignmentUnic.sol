// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CrowdfundingAssignmentUnic {

    constructor() {
    }

    // Declare Project as a struct datatype
    struct Project {
        uint256 projectID;
        string projectTitle;
        string projectDescription;
        address projectOwner;
        uint256 projectParticipationAmount; // a specific amount that each user is required to contribute when participating in the project
        uint256 projectTotalFundingAmount;
        // uint256 projectFundingGoal; // an additional attribute that may be used to set a target for the amount to be raised.
    }

    // Declare a projects mapping filled with all the Projects (with Project datatype)
    mapping(uint256 => Project) private projects;
    // maps from project IDs to a mapping of user addresses to participation amounts
    mapping(uint256 => mapping(address => uint256)) private participation;

    // A variable that will be used to assign project IDs automatically
    // We may also use some external library to assign a unique ID for each Project
    uint nextProjectID = 1;

    // Implement a setter function where project owners can list a project
    function createProject(string memory _projectTitle, string memory _projectDescription, uint256 _projectParticipationAmount) public {
        // Make sure that the user fills out the necessary data (in particular that it is not empty)
        require(bytes(_projectTitle).length > 0, "Project title cannot be empty.");
        require(bytes(_projectDescription).length > 0, "Project description cannot be empty.");
        require(_projectParticipationAmount > 0, "Participation amount must be greater than 0.");

        Project memory newProject = Project(nextProjectID, _projectTitle, _projectDescription, msg.sender, _projectParticipationAmount, 0); // projectOwner will be assigned the address of the sender of the transaction
        projects[nextProjectID] = newProject;
        nextProjectID++;
    }

    function getProjectDetails(uint256 _projectID) public view returns (uint256, string memory, string memory, address, uint256, uint256) {
        // Check if the project exists
        require(projects[_projectID].projectOwner != address(0), "Project does not exist.");

        Project storage project = projects[_projectID];
        return (project.projectID, project.projectTitle, project.projectDescription, project.projectOwner, project.projectParticipationAmount, project.projectTotalFundingAmount);
    }


    // A payable setter function called participateToProject(), where users can interact with the smart contract to fund a specific project
    // When a user contributes to a project, the smart contract should record the user's address, project ID, and the amount of their participation.
    function participateToProject(uint256 _projectID) public payable {

        // Check if the project exists
        require(projects[_projectID].projectOwner != address(0), "Project does not exist.");

        uint _participationAmount = msg.value;
        
        // retrieve the Project struct with the specific projectID from the projects mapping, and assign it to the project storage variable
        Project storage project = projects[_projectID];

        // Make sure that the _participationAmount the user is about to transfer is equal to the projectParticipationAmount defined by the projectOwner 
        require(_participationAmount == project.projectParticipationAmount, "Participation amount is not correct.");

        project.projectTotalFundingAmount += _participationAmount;
        participation[_projectID][msg.sender] += _participationAmount;
        payable(address(this)).transfer(_participationAmount);
    }


    // A getter function named retrieveContributions(), which allows users to retrieve the contributions made by a specific Ethereum address to a specific project.
    // The user needs to input the Ethereum address and the projectID to retrieve the relevant information.
    function retrieveContributions(uint256 _projectID, address _user) public view returns (uint) {
        // Ensure that the project exists
        require(projects[_projectID].projectOwner != address(0), "Invalid project ID");

        // Ensure that the user has participated in the project
        require(participation[_projectID][_user] > 0, "User has not participated in this project");

        return participation[_projectID][_user];
    }

    // A withdrawal function, named withdrawFunds(), that can only be called by the project owner of the respective project. 
    // When called, this function should transfer the current projectTotalFundingAmount of the specific project to the project owner's wallet.
    function withdrawFunds(uint _projectID) public payable {
        Project storage project = projects[_projectID];

        require(msg.sender == project.projectOwner, "You must be the project Owner to withdraw the funds.");
        require(project.projectTotalFundingAmount > 0, "There are no funds to withdraw for this project.");

        address payable _to = payable(project.projectOwner);
        _to.transfer(project.projectTotalFundingAmount);
        
        // The funding collected total amount shall be set to 0 in the mapping to remove the possibility to withdraw again
        project.projectTotalFundingAmount = 0;
    }


    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}

