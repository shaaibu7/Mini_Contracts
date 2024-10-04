// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract StackClub {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    address[] members;

    modifier memberExists() {
        bool memberExist;
        for(uint256 i = 0; i < members.length; i++) {
            if(members[i] == msg.sender) {
                memberExist = true;
            }
        }
        require(memberExist);
        _;
    }

    function addMember(address memberAddress) external  memberExists {
        members.push(memberAddress);
    }

    function isMember(address validMember) public view returns(bool member) {
        for(uint256 i = 0; i < members.length; i++ ) {
            if(members[i] == validMember) {
                member = true;
                return member;
            }
        }

    }

    function removeLastMember() public  memberExists {
        members.pop();
    }

}