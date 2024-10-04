// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) payable{
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    modifier onlyOwner() {
        if(msg.sender != arbiter) {
            require(false);
        }
        _;
    }

    event Approved(uint);

    function approve() external onlyOwner {
        uint256 contractBalance = address(this).balance;
        (bool success, ) = beneficiary.call{ value:  address(this).balance}("");
        require(success);
        emit Approved(contractBalance);
    }

    
    
}