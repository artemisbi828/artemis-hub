## Attributes vs Predicates

> - **If a fact can be determined from a single row without reference to other rows or time windows, it is an ATTRIBUTE.**  
> - **If it requires evaluation logic across rows, time, or existence checks, it is a PREDICATE.**

Your case fails **all three**:

| Test                              | Result |
| --------------------------------- | ------ |
| Needs other rows                  | ✅ yes  |
| Needs existence checks            | ✅ yes  |
| Can change via late-arriving rows | ✅ yes  |
| Depends on taxonomy               | ✅ yes  |

Therefore it is a predicate.
