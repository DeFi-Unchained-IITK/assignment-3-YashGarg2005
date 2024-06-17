// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { Test } from "YASH_GARG_231185/question_3/EmployeeRegistree/forge-std/src/Test.sol";
import { EmployeeRegistree } from "YASH_GARG_231185/question_3/EmployeeRegistree/employee.sol";
contract EmployeeRegistreeTest is Test {
    EmployeeRegistree public employee;
    function setUp() public{
        employee = new EmployeeRegistree();
        employee.AddEmployee("candidate_1","GM",123);//in thousand dollars
        employee.AddEmployee("candidate_2","VP",456);//in thousand dollars
    }
    function testAddEmployee() public view{
        uint expected = 2;
        uint actual = employee.nextID();
        assertEq(expected, actual);
    }
    function testGetEmployee() public view{
        string memory expectedName = "candidate_1";
        string memory expectedposition = "GM";
        uint expectedSalary = 123;
        (string memory name, string memory position, uint salary) = employee.GetEmployee(0);
        assertEq(expectedName, name);
        assertEq(expectedposition, position);
        assertEq(expectedSalary, salary);

    }
    function testUpdateEmployee() public{
        employee.UpdateEmployee(0,"candidate_1","GM",789);
        (string memory name, string memory position, uint salary) = employee.GetEmployee(0);
        assertEq("candidate_1", name);
        assertEq("GM", position);
        assertEq(789, salary);

    }
    function testDelEmployee() public{
        employee.DelEmployee(0);
        uint expected = 2;
        uint actual = employee.nextID();
        assertEq(expected, actual);

    }
}
