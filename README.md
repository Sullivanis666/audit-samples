# Audit Samples

This repository contains **sample smart contract audits** and **automated analysis reports**.  
It is designed as a public portfolio to demonstrate methodology, tooling, and reporting style in blockchain security research.

---

## 📌 Purpose

- Showcase open-source audit samples for educational and reference purposes.  
- Demonstrate automated triage pipelines for smart contract vulnerability discovery.  
- Provide transparency into methodology and tooling without exposing client-sensitive data.  

---

## 🛠 Tooling & Pipeline

The audit process integrates both **automated** and **manual** steps:

1. **Contract Preparation**
   - Flatten contracts (e.g., ERC20 from OpenZeppelin).
   - Store in `contracts/` directory.

2. **Automated Triage**
   - [Slither](https://github.com/crytic/slither): Static analysis framework for Solidity.  
   - [Mythril](https://github.com/ConsenSys/mythril): Symbolic execution engine for Ethereum smart contracts.  
   - Scripts (`scripts/triage.sh`) automate the workflow:
     - Run both tools against a target contract.
     - Save outputs into `reports/`.

3. **Reporting**
   - Reports are exported as plain text for transparency.  
   - Summaries include contract features, detected patterns, and potential vulnerabilities.  

---

## 📂 Repository Structure

```
audit-samples/
 ├─ contracts/        # Flattened smart contracts for testing
 │   └─ ERC20_flat.sol
 ├─ reports/          # Automated tool outputs
 │   ├─ slither_flat_report.txt
 │   └─ mythril_flat_report.txt
 ├─ scripts/          # Analysis automation scripts
 │   └─ triage.sh
 └─ README.md         # Project overview
```

---

## ⚠️ Disclaimer

- All contracts and reports in this repository are **publicly available samples**.  
- No client data or proprietary code is included.  
- Reports are for **educational and demonstration purposes only** and should not be considered production-level security audits.  

---

## 📩 Contact

- GitHub: [Sullivanis666](https://github.com/Sullivanis666)
- Twitter: [Sulliva77787490](https://x.com/Sulliva77787490)
- Email: sullivanis666@gmail.com

---
