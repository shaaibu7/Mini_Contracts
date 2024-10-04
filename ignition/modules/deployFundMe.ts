import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const FundMeModule = buildModule("FundMeModule", (m) => {

    const FundMeClub = m.contract("FundMe", ["0x72AFAECF99C9d9C8215fF44C77B94B99C28741e8"]);

    return { FundMeClub };
});

export default FundMeModule;
