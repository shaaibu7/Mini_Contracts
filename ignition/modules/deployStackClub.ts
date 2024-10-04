import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StackClubModule = buildModule("StackClubModule", (m) => {

    const stackClub = m.contract("StackClub");

    return { stackClub };
});

export default StackClubModule;
