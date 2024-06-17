// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public EC;//here admin is election commision
    struct Candidate { //creating a structure
        string name;
        uint voteCount;
    }
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;//for creating track of number of candiates
    mapping(address => bool) public registeredVoters;
    mapping(address => bool) public hasVoted;//to know if voter has voted or not

    modifier onlyAdmin() {
        require(msg.sender == EC, "Only admin can call this function");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(registeredVoters[msg.sender], "Sender is not a registered voter");//registeredVoters[msg.sender] will return a boolean
        _;
    }

    constructor() {
        EC = msg.sender;
    }

    function addCandidate(string memory name) public onlyAdmin {
        candidates[candidatesCount] = Candidate(name, 0);
        candidatesCount++;
    }

    function registerVoter(address voter) public onlyAdmin {//putting voter address to add the voter in the mapping done by EC
        registeredVoters[voter] = true;
    }

    function vote(uint candidateId) public onlyRegisteredVoter {//selecting canditate like BJP or congress
        require(!hasVoted[msg.sender], "Voter has already voted");
        require(candidateId < candidatesCount, "Invalid candidate ID");

        hasVoted[msg.sender] = true;
        candidates[candidateId].voteCount++;//using the structure
    }

    function getVoteCount(uint candidateId) public view returns (uint) {
        require(candidateId < candidatesCount, "Invalid candidate ID");
        return candidates[candidateId].voteCount;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVoteCount) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerName = candidates[i].name;
                winnerVoteCount = winningVoteCount;
            }
        }
    }
}
