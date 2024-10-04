// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract VotingProposal {

    mapping(address => bool) member;

    uint8 constant VOTE_THRESHOLD = 10;
    constructor(address[] memory proposalAddress)  {
        for(uint i = 0; i < proposalAddress.length; i++) {
            member[proposalAddress[i]] = true;
        }
        member[msg.sender] = true;
    }

    enum VoteStates {Absent, Yes, No}

    struct Proposal {
        address target;
        bytes data;
        bool executed;
        uint yesCount;
        uint noCount;
        mapping (address => VoteStates) voteStates;
    }
    
    Proposal[] public proposals;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voterAddress);
    
    
    function newProposal(address _target, bytes calldata _data) external {
        require(member[msg.sender]);
        Proposal storage proposal = proposals.push();
        proposal.target = _target;
        proposal.data = _data;
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint _proposalId, bool _supports) external {
        require(member[msg.sender]);
        Proposal storage proposal = proposals[_proposalId];

        // clear out previous vote 
        if(proposal.voteStates[msg.sender] == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if(proposal.voteStates[msg.sender] == VoteStates.No) {
            proposal.noCount--;
        }

        // add new vote 
        if(_supports) {
            proposal.yesCount++;
        }
        else {
            proposal.noCount++;
        }
        emit VoteCast(_proposalId, msg.sender);

        // we're tracking whether or not someone has already voted 
        // and we're keeping track as well of what they voted
        proposal.voteStates[msg.sender] = _supports ? VoteStates.Yes : VoteStates.No;

        if(proposal.yesCount == VOTE_THRESHOLD && !proposal.executed) {
            (bool success,) = proposal.target.call(proposal.data);
            require(success);
        }
    }
}