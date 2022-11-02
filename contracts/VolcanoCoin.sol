// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

    uint totalSupply = 10000;
    mapping(address => uint) public balances;
    mapping(address => Payment[]) userPaymentRecords;

    constructor() {
        balances[owner()] = totalSupply;
    }

    struct Payment {
        address to;
        uint amount;
    }

    event supplyIncreased(uint);
    event paymentTransferComplete(address, uint);

    function getTotalSupply() public view returns (uint){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner() {
      totalSupply += 1000;
      emit supplyIncreased(totalSupply);
    }

    function transfer(address _to, uint _amount) public {
        uint balance = balances[msg.sender];
        require(balance >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        userPaymentRecords[msg.sender].push(Payment({to: _to, amount: _amount}));
        // adds payment to msg.sender's array of payments
        emit paymentTransferComplete(_to, _amount);
    }

    function getuserPaymentRecords(address userAddress) public view returns (Payment[] memory) {
        return userPaymentRecords[userAddress];
        //print the array of payments made by a specific address
    }
}
