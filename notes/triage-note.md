# Quick Start: Rapid Triage of ERC20 with Slither + Mythril

This note documents a fast, practical triage workflow: how to run automated checks on an ERC20 contract and interpret common results, focusing on the `approve` race condition. 
Examples are taken from the `audit-samples` repository.

---

## 1. Why Rapid Triage?

Before a full manual audit, rapid triage helps:

- Catch obvious high-risk patterns (reentrancy, privilege abuse, arithmetic issues).  
- Decide how much time to invest in deeper manual analysis.  
- Produce a short report or PoC priority list for the project owner.  

The steps: **Flatten → Run Slither (static) → Run Mythril (symbolic execution) → Interpret results + quick recommendations**

---

## 2. Environment & Quick Run

Requires `solc`, `slither`, and `myth`.  

```bash
git clone https://github.com/Sullivanis666/audit-samples.git
cd audit-samples
./scripts/triage.sh contracts/ERC20_flat.sol
```

Reports are saved to:

- `reports/slither_report.txt`
- `reports/mythril_report.txt`

---

## 3. Reading Common Output

**Slither excerpt:**

```text
Number of contracts: 7
ERC20 detected
Approve Race Cond.  (informational)
```

- `Approve Race Cond.` = potential ERC20 allowance race issue.
- Severity depends on whether `increaseAllowance` / `decreaseAllowance` are implemented.
- If Mythril shows `input files do not contain any valid contracts`, flatten the file first.

---

## 4. The `approve` Race Condition

**Overview**:
 When a user changes an allowance (e.g. from 100 → 200), an attacker can front-run with two txs, exploiting the window before the change is finalized.

**Common mitigations**:

1. Prefer `increaseAllowance` / `decreaseAllowance` (best practice).
2. Require setting allowance to 0 before assigning a new value.
3. Avoid critical reliance on `approve` → `transferFrom` flows; consider pull or signature-based models.

**Example helper function**:

```solidity
function safeChangeAllowance(IERC20 token, address spender, uint256 newAmount) internal {
    uint256 current = token.allowance(address(this), spender);
    if (current > 0) {
        token.approve(spender, 0);
    }
    token.approve(spender, newAmount);
}
```

Better: rely on OpenZeppelin’s `SafeERC20` or native `increaseAllowance`.

---

## 5. Quick Checklist

- ✅ Flatten the contract if Mythril fails.
- ✅ Run Slither → save `reports/slither_report.txt`.
- ✅ Run Mythril → save `reports/mythril_report.txt`.
- ✅ If `Approve Race Condition` flagged → mark as **manual confirmation needed**.
- ✅ Recommend client-side `increaseAllowance` or contract-side `safeChangeAllowance`.
- ✅ Escalate immediately if reentrancy, permission bypass, or logic flaws are detected.

---

## 6. From Automated to Manual Audit

Rapid triage is a **filter**, not a final verdict.
 Next steps usually include:

- Line-by-line review of key functions (`transfer`, `approve`, `constructor`, withdrawal functions).
- Write fuzzing/unit tests in Foundry or Hardhat to validate edge cases.
- Provide audit timeline + risk-based proposal for the project.

---

## 7. Summary

Automated triage gives you useful insights in under 30 minutes and sets a solid base for deeper manual review.
