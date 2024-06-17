// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { Test } from "YASH_GARG_231185/question_3/Library/forge-std/src/Test.sol";
import { Library } from "YASH_GARG_231185/question_3/Library/library.sol";
contract LibraryTest is Test {
   Library public book;
   function setUp() public {
    book = new Library();
    book.addBook("Percy Jackson","Rick");
    book.addBook("Harry potter","J.K. Rowling");
   }
   function testaddBook() public view {
    uint expected = 2;
    uint actual = book.nextID();
    assertEq(actual,expected);
   }
   function testgetBookDetails() public view {
    (uint ID, string memory title, string memory author, bool is_available ) = book.getBookDetails(0);
    string memory name = "Percy Jackson";
    string memory auth = "Rick";
    uint number = 0;
    bool available = true;
    assertEq(title,name);
    assertEq(author,auth);
    assertEq(ID,number);
    assertEq(is_available,available);

    }

    function testborrowBook() public  {//got error this function modifies the state thus can be of the type view
        book.borrowBook(0);
        (, , , bool is_available ) = book.getBookDetails(0);
        assertFalse(is_available);
    }
    function testreturnbook() public {
        book.borrowBook(0);
        (, , , bool is_available ) = book.getBookDetails(0);
        assertFalse(is_available);
        book.returnBook(0);
        (, , , bool is_available2 ) = book.getBookDetails(0);
        assertTrue(is_available2);
    }

}

