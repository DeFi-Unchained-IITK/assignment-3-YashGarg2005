// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from "lib/forge-std/src/Test.sol";
import { Voting } from "../src/Voting.sol";

contract TestVoting is Test {
    Voting voting;
    address voter1;
    address voter2;

    function setUp() public {
        voting = new Voting();
        voter1 = address(0x123);
        voter2 = address(0x456);

        // Register voters
        voting.registerVoter(voter1);
        voting.registerVoter(voter2);

        // Add candidates
        voting.addCandidate("Candidate 1");
        voting.addCandidate("Candidate 2");
    }

    function testAddCandidate() public view {
        uint expected = 2; // Already added in setUp
        uint actual = voting.candidatesCount();
        assertEq(actual, expected, "Candidate should be added");
    }

    function testRegisterVoter() public {
        address voter3 = address(0x789);
        voting.registerVoter(voter3);
        bool isRegistered = voting.registeredVoters(voter3);
        assertTrue(isRegistered, "Voter should be registered");
    }

    

    function testGetWinner() public {
        // Cast votes
        vm.prank(voter1);
        voting.vote(0);  // Voter 1 votes for Candidate 1
        
        vm.prank(voter2);
        voting.vote(1);  // Voter 2 votes for Candidate 2

        (string memory name, uint voteCount) = voting.getWinner();
        assertTrue(bytes(name).length > 0, "Winner should have a name");
        assertTrue(voteCount > 0, "Winner should have votes");
    }
}
