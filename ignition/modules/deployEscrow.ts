import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const EscrowModule = buildModule("EscrowModule", (m) => {

    const escrow = m.contract("Escrow", [
      "0xE859ac304020Dd3039082827d2Cbd25979297BDD",
      "0x1B99A1068dBE586c6F6D03211C0F352ce3534b2f"
    ]);

    return { escrow };
});

export default EscrowModule;
