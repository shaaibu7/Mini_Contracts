// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract crowdFunding {
    address owner;

    // this mapping handles the status of donation
    mapping(string => bool) endDonation;

    // using constant to avoid magic numbers
    uint constant private ZERO = 0;

    // This modifier handles calling the adminWithdraw  function to only the admin
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        // Give ownership of the contract to the deployer of the contract
        owner = msg.sender;
    }

    // Creating Events
    event CampaignCreated(uint campaignID);
    event DonationReceived(uint campaignID);
    event CampaignEnded(uint campaignID);

    // structure of creating a new campaign and the corresponding values it should have
    struct Campaign {
        string title;
        string description;
        address benefactor;
        uint goal;
        uint duration;
        uint deadline;
        uint amountRaised;
    }

    // storing all created campaigns in an array to keep track of them
    Campaign[] public campaigns;

    function createCampaign(string memory _title, string memory  _description, address _benefactor, uint _goal, uint duration) public {
        Campaign storage campaign = campaigns.push();
        campaign.title = _title;
        campaign.description = _description;
        campaign.benefactor = _benefactor;
        campaign.goal = _goal;
        campaign.duration = duration;
        campaign.deadline = block.timestamp + duration;
        require(_goal > ZERO); // validating that the goal provided is greater than zero
        emit CampaignCreated(campaigns.length + 1);
    }

    function donate(uint _campaignId) public payable  {
        // Iterating the campaings array to get specific campaignId
        for(uint256 i = 0; i < campaigns.length; i++) {
            require((campaigns[i].deadline) < block.timestamp); //Ensuring deadline for campaign is not reached
            require(!endDonation[campaigns[_campaignId].title]); // reject donation after end of campaign
            if(campaigns[i].goal == campaigns[_campaignId].goal) {
                 campaigns[i].amountRaised +=  msg.value;
            }
        }
        emit DonationReceived(_campaignId);
    }

    function endCampaign() public {
        for(uint256 i = 0; i < campaigns.length; i++) {
            if(campaigns[i].deadline > block.timestamp) {
                endDonation[campaigns[i].title] = true; // handle end of campaign
                uint amount = campaigns[i].amountRaised;
                (bool success,) = (campaigns[i].benefactor).call{ value: amount}("");
                require(success);
                emit DonationReceived(i);
            }
        }
    
    }

    function adminWithdraw() public onlyOwner {
        // Iterating over campaigns to check any campaign that has ended and has remaining funds
        for(uint i = 0; i < campaigns.length; i++) {
            if(endDonation[campaigns[i].title] && campaigns[i].amountRaised > 0) { // check if campaign has ended and there are remaining funds
                uint amount = campaigns[i].amountRaised;
                (bool success, ) = (msg.sender).call{ value: amount }(""); // Transfer remaining funds to owner of contract
                require((success));

            }
        }
    }


}