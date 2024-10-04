import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const VotingContractModule = buildModule("VotingContractModule", (m) => {

    const VotingContract = m.contract("VotingContract");

    return { VotingContract };
});

export default VotingContractModule;
