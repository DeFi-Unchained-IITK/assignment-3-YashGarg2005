// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Question1{
  address public owner;
  constructor() {
    owner=msg.sender; //from github shared
  }
  function is_prime (int n)  public pure returns (bool) {
    int i =n ;
    int flag = 1;
    for (int j=2 ; j<i ; j++){
      if (i % j==0){
        flag=0;
        break;
      }
    }
      if (flag==0){
        return false;
      }
      else{
        return true;
      }

  


  }
  event ValueSet(address value);

  function check (int _n) public{
    require (_n>1,"Input should be graeter than one");
    require (is_prime(_n),"The number should be prime");
    owner = msg.sender;
    emit ValueSet(owner);


  }
 
  

}