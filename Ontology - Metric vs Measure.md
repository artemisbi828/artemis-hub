# Measure
Pure math. No implication of judgement or performance. Objective "is".
Aggregates rows. (predicates are bool and select rows)
- COUNT, SUM, AVG, ratio
- Numeric → answers "how much / how many" over a set of records



# Metric
Has meaning → expectation. Expected to be interpreted or acted upon
- **requires** comparison, target, or trend 
- "is this good? bad? improving? acceptable"
- produces decisions; 

# Measure

Pure math. No implication of judgement or performance. Objective "is".
Aggregates rows. (predicates are bool and select rows)
- COUNT, SUM, AVG, ratio
- Numeric → answers "how much / how many" over a set of records

## 3 Measure Types
1. **Entity‑true measures**  (scalar)
    → patient lifetime production value 
    
2. **Aggregative measures**   (tabular)
    → require a cohort to be meaningful  
    _(e.g., conversion rate, collection rate)_
    
3. **Ratios of aggregates**  
    → defined only at evaluation scope

# Semantic Pivots
Try to change this culturally:

❌ Calling ratios “metrics” in Gold  
❌ Hardcoding targets into SQL  
❌ Embedding performance judgment in measures  

> [!info] Definition
> business-evaluative construct that: 
> - has intent (performance, success, health)
> - has context (scope, comparison baseline, time horizon)
> - has call-to-action 


#### Naming Anti-Patterns (Make These Illegal)

❌ Calling ratios “metrics” in Gold  
❌ Hardcoding targets into SQL  
❌ Embedding performance judgment in measures  
❌ Treating dashboard visuals as documentation



### 3 buckets
1. **Entity‑true measures**  (scalar)
    → meaningful per single instance  
    _(e.g., patient lifetime value)_
    
2. **Aggregative measures**   (tabular)
    → require a cohort to be meaningful  
    _(e.g., conversion rate, collection rate)_ ✅
    
3. **Ratios of aggregates**  
    → defined only at evaluation scope ✅✅
    
[[net_collection_rate_pct_actual]] is **#3**.


