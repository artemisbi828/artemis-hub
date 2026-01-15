Prompt
> [!info] Business Logic Documentation
> I need to deeply understand the business logic of [METRIC/CALCULATION NAME].
> 
> CONTEXT:
> - Business purpose: [What decision does this drive?]
> - Current understanding: [Your hypothesis about what it does]
> - Specific confusion: [The exact temporal/logical aspect you're unsure about]
> 
> CODE: [Paste full code including all nested functions]
> 
> REQUIREMENTS:
> 1. **Explanation Depth**: Don't just describe the code syntax. Explain:
>    - The business intent behind each condition
>    - How temporal windows work (inclusive/exclusive boundaries)
>    - Edge cases and tie-breakers
>    - What happens to related records (does past data change retroactively?)
> 
> 2. **Temporal Scenarios**: For time-based logic, provide:
>    - Concrete examples with specific dates/times
>    - Boundary condition behavior (Day 30 vs Day 31)
>    - Whether calculations are point-in-time or retroactive
> 
> 3. **Test Case Generation**: Provide:
>    - SQL queries to find real-world examples for each scenario
>    - Expected outcomes for each test case
>    - Validation queries to confirm the logic is working correctly
> 
> 4. **Edge Cases**: Identify:
>    - Tie-breaker logic (e.g., same datetime, what's the sort order?)
>    - Null handling
>    - Cascading effects (does changing one record affect others?)
> 
> SPECIFIC QUESTIONS:
> - [Your specific question, e.g., "If appointment.a is on Day 1 and appointment.b is on Day 31, are both IsNetAdded = 1?"]

# LLM Choice
```
Stick with Claude 3.7 Sonnet for this type of task. It excels at:

Multi-step logical reasoning
SQL generation with proper syntax
Business context translation
Temporal/sequential logic
Comprehensive test coverage thinking

Only switch to o1 (if available) if you need even deeper reasoning on extremely complex nested logic or mathematical proofs.

GPT-4o → more creative w SQL
```