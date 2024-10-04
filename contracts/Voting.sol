// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract VotingContract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: create a public state variable: an array of votes
	Vote[] public votes;


	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
		bool validVoter = hasVoted(msg.sender);
		if(validVoter) {
			require(false);
		}
		votes.push(Vote(choice, msg.sender));
	}

	function votersInfo(address voterAddress) internal view returns(Vote memory, bool) {
		for(uint256 i = 0; i < votes.length; i++) {
			if(votes[i].voter == voterAddress) {
				return(votes[i], true);
			}
			
		}
		
	}

	function hasVoted(address sender) public view returns(bool) {
		 (, bool found) = votersInfo(sender);
		 return found;
		
	}

	function findChoice(address voterAddress) external view returns(Choices) {
		 (Vote memory vote, bool found) = votersInfo(voterAddress);
		 require(found, "Voter has not cast a vote");
		 return vote.choice;
	}
	

	function changeVote(Choices _newChoice) external returns(Vote memory) {
		for(uint256 i = 0; i < votes.length; i++) {
			if(votes[i].voter == msg.sender) {
				votes[i].choice = _newChoice;
			}
		}

 	}


}