Simpson's Paradox is a phenomenon in probability and statistics where a trend appears in several different groups of data but disappears or reverses when these groups are combined.

It most often occurs when **lurking variables** (hidden factors) aren't accounted for, leading to a conclusion that seems to contradict the individual sets of data.

---

## How It Works

The paradox typically arises in social-science and medical-science statistics. It happens when the sizes of the groups being compared are disproportionately different, or when a third variable influences both the cause and the effect.

### A Classic Example: Berkeley Gender Bias Case

One of the best-known real-world examples occurred at UC Berkeley in 1973.

- **The Appearance:** Overall admission figures showed that men were significantly more likely to be admitted than women.
    
- **The Reality:** When looking at individual departments, it turned out that most departments were actually _more_ likely to admit women or had no significant difference.
    
- **The "Lurking Variable":** It was discovered that women tended to apply to more competitive departments with lower overall admission rates, while men applied to less competitive departments with higher admission rates.
    

---

## The Mathematical Breakdown

To see how the math "tricks" the eye, consider this simplified table of success rates:

|**Group**|**Strategy A**|**Strategy B**|
|---|---|---|
|**Group 1**|1/10 (**10%**)|0/1 (**0%**)|
|**Group 2**|6/9 (**66%**)|50/80 (**62.5%**)|
|**Combined**|7/19 (**36.8%**)|50/81 (**61.7%**)|

In this scenario, Strategy A is better in Group 1 _and_ better in Group 2. However, because Strategy B has so many more "trials" in the high-success-rate group (Group 2), its **weighted average** looks much better in the final total.

---

## Why It Matters

Simpson's Paradox is a cautionary tale for anyone working with data (like your work in **FP&A and Business Intelligence**). It proves that:

1. **Aggregation can be misleading:** Summary dashboards can hide crucial nuances in the underlying data.
    
2. **Causality is key:** You have to understand _why_ the data is being grouped a certain way before you can trust the total.
    
3. **Domain knowledge is required:** Statistical skill alone isn't enough; you need to know the context of the business or experiment to identify hidden variables.
    

Would you like me to find a Python script or a SQL query that demonstrates how to detect this paradox in a dataset?