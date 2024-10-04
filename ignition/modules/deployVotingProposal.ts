import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const VotingProposalModule = buildModule("VotingProposalModule", (m) => {

    const VotingProposalContract = m.contract("VotingProposal", [["0x1B99A1068dBE586c6F6D03211C0F352ce3534b2f"]]);

    return { VotingProposalContract };
});

export default VotingProposalModule;
