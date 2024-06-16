// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract SimpleBank {
    struct Fund {
        uint ID;
        string name;
        address place;
    }

    address private owner;
    uint private nextID = 0;

    mapping(uint => Fund) private funds; 
    mapping(address => uint) private balances; 

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    
    
    function deposit() public payable onlyOwner {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[owner] += msg.value;
        
    }

   
    function withdraw(uint256 amount) public onlyOwner {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[owner] >= amount, "Insufficient balance");

        balances[owner] -= amount;
        payable(owner).transfer(amount);

        
    }

    
    function transfer(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balances[owner] >= amount, "Insufficient balance");

        balances[owner] -= amount;
        balances[to] += amount;

       
    }

   
    function getBalance() public view onlyOwner returns (uint256) {
        return balances[owner];
    }

    
    function addFund(string memory _name, address _place) public onlyOwner {
        funds[nextID] = Fund(nextID, _name, _place);
        nextID++;
    }

    
    function getFundDetails(uint ID) public view returns (uint, string memory, address) {
        require(ID >= 0 && ID < nextID, "Invalid fund ID");
        Fund storage fund = funds[ID];
        return (fund.ID, fund.name, fund.place);
    }
}

