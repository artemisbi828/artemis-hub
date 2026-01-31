---
aliases:
  - modulo
---

Divides without a remainder 

`where RN %1000 = 0 → give me where RN is exactly a multiplier of 1000 (no remainders)`


### The Comparison: 166 / 12 vs 166 % 12
Think of it like this: If you share 166 items equally among 12 people, the division tells you how many each person gets, and the modulo tells you how many are "left over" in your hand.

#### 1. Division: `166 / 12`

- **The Question:** How many full times does 12 go into 166?
- **The Math:** $12 \times 13 = 156$. ($12 \times 14 = 168$, which is too high).
- **The Result:** **$13$** (This is called the _quotient_).
- _Note: In T-SQL, if both numbers are integers, it will return 13. If you use decimals like `166 / 12.0`, it returns $13.833$.

#### 2. Modulo: `166 % 12`

- **The Question:** After taking out all the full 12s, what is the **leftover** remainder?
- **The Math:** $166 - (12 \times 13) \rightarrow 166 - 156 = 10$.
- **The Result:** **$10$** (This is the _remainder_).
