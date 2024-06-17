// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Library {
    struct Book {
        uint ID;
        string name;
        string author;
        bool isAvailable;
    }

    address private owner;
    Book[] private bookshelf;
    uint public nextID = 0;

    mapping (uint => Book) private books; // Mapping to store books by ID
    mapping (uint => address) private borrowedBooks; // Mapping to store book borrowers

    constructor() {
        owner = msg.sender;
    }

    modifier validBook(uint ID) {
        require(ID >= 0 && ID < nextID, "Invalid book ID");
        _;
    }

    function addBook(string memory _name, string memory _author) public {
        books[nextID] = Book(nextID, _name, _author, true); //in question 2 i did push command 
        bookshelf.push(books[nextID]);
        nextID++;
    }

    function borrowBook(uint ID) public validBook(ID) {
        Book storage book = books[ID];
        require(book.isAvailable, "Book not available");
        
        book.isAvailable = false;
        borrowedBooks[ID] = msg.sender;
    }

    function getBookDetails(uint ID) public view validBook(ID) returns (uint, string memory, string memory, bool) {
        Book storage book = books[ID];
        return (book.ID, book.name, book.author, book.isAvailable);
    }

    function returnBook(uint ID) public validBook(ID) {
        require(borrowedBooks[ID] == msg.sender, "You didn't borrow this book");

        books[ID].isAvailable = true;
        delete borrowedBooks[ID];
    }
}