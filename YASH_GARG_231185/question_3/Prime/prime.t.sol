// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from "lib/forge-std/src/Test.sol";
import { Question1 } from "../src/prime.sol";

contract TestQuestion1 is Test {
    Question1 prime;

    function setUp() public {
        prime = new Question1();
    }
    function test_is_prime() public view { //checking for prime number only
        assertTrue(prime.is_prime(7));
    }

}
