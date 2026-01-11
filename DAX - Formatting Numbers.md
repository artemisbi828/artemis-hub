In DAX, you have two primary ways to handle formatting: through the **Model View** (UI-based) or through the **`FORMAT` function** (used inside measures for specific labels or dynamic strings).

### 1. The "Model View" Method (Recommended)

This is the standard way to format measures so they appear correctly in all charts, cards, and tables without breaking the underlying numeric data.

|**Goal**|**Ribbon Settings**|
|---|---|
|**Percentage (1 decimal)**|Select Measure $\rightarrow$ Measure Tools $\rightarrow$ Format: **Percentage** $\rightarrow$ Decimals: **1**|
|**Currency (Nearest Dollar)**|Select Measure $\rightarrow$ Measure Tools $\rightarrow$ Format: **Currency** $\rightarrow$ Decimals: **0** $\rightarrow$ Check **( , )** Thousands Separator|

---

### 2. The `FORMAT` Function (For Strings/Labels)

Use this only if you are building a dynamic text string (e.g., "The total is $5,000"). **Warning:** Using this on a calculation turns the result into **Text**, which means you cannot use it in a chart's Y-axis.

**SQL-to-DAX Formatting Cheat Sheet:**

Code snippet

```
-- Percentage with 1 Decimal Point (e.g., 12.5%)
FormattedPct = FORMAT([Measure], "0.0%")

-- Currency Round to Nearest Dollar with Thousands Separator (e.g., $1,250)
FormattedCurrency = FORMAT([Measure], "$#,##0")
```

---

### 3. Practical Usage in your Normalization Project

Since you are calculating ratios like **Conversion Rate**, you will likely want the "Hybrid" measure for report headers:

Code snippet

```
Dashboard Header = 
"Current Conversion: " & FORMAT([Conversion Rate TY], "0.0%") & 
" vs LY: " & FORMAT([Conversion Rate LY], "0.0%")
```

---

### 4. Obsidian Cheat Sheet: DAX Format Strings

Add these common strings to your Obsidian vault for quick copy-pasting:

|**String**|**Result**|**Note**|
|---|---|---|
|`"0.0%"`|`15.4%`|Percentage with 1 decimal|
|`"$#,##0"`|`$1,250`|Currency, no cents, with comma|
|`"$#,##0.00"`|`$1,250.50`|Currency with cents|
|`"#,##0"`|`1,250`|Number with thousands separator|
|`"yyyy-MM-dd"`|`2026-01-10`|ISO Date format|

---

### Pro-Tip: Precision vs. Formatting

When you format a currency to the "Nearest Dollar" in the UI (Setting decimals to 0), Power BI **still keeps the decimals in the background** for math. If you want to actually **remove** the decimals (for logic/binning), use the `ROUND` function:

`RoundedAmount = ROUND([TotalAmount], 0)`

**Would you like me to show you how to use "Field Parameters" so you can let your users toggle between showing Percentages and Currencies in the same chart?**