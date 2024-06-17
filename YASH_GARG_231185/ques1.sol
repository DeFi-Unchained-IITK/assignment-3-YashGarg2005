// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    // Mapping to keep track of user balances
    mapping(address => uint256) private balances;
    
    // Event to log deposits
    event Deposit(address indexed user, uint256 amount);
    
    // Event to log transfers
    event Transfer(address indexed from, address indexed to, uint256 amount);
    
    // Event to log withdrawals
    event Withdrawal(address indexed user, uint256 amount);
    
    // Function to deposit ether to the bank account
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    // Function to transfer ether from one user's bank account to another user's bank account
    function transfer(address to, uint256 amount) external {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
        emit Transfer(msg.sender, to, amount);
    }
    
    // Function to withdraw ether from the user's bank account to their blockchain account
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        
        emit Withdrawal(msg.sender, amount);
    }
    
    // Function to check the balance of the user
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
    
    // Function to check the balance of any user (optional, can be removed if not needed)
    function getBalanceOf(address user) external view returns (uint256) {
        return balances[user];
    }
}
