import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const crowdFundingModule = buildModule("crowdFundingModule", (m) => {

    const crowdFundingContract = m.contract("crowdFunding");

    return { crowdFundingContract };
});

export default crowdFundingModule;
