LOCAL TO UTC CONVERSION

11/24/2025 5:00 AM  UTC = 11/24/2025 12:00 AM EST (+5 HRS DST or +4 HRS)
11/24/2025 5:00 AM  UTC = 11/23/2025 11:00 PM CST (+6 HRS DST or +5 HRS)

SCENARIO 1:
Contract 1 -- 11/23/2025 11:59 PM EST = 11/24/2025 4:59 AM  UTC
Contract 2 -- 11/24/2025 12:01 AM EST = 11/24/2025 5:01 AM  UTC

When we convert the UTC and write to our datalake to credit a contract to a specific date

We should change it back to their local time zone (EST or CST)

If DATATEAM assumes UTC then Contract 1 would be wrong b/c it happened in 11/23/2025 -- that date should have been credited

This is what happened initially until business caught it.

SCENARIO 2:
Contract 3 -- 11/23/2025 11:01 PM CST = 11/24/2025 5:01 AM  UTC
Contract 3 -- 11/23/2025 11:01 PM CST = 11/24/2025 12:01 AM  EST

If DATATEAM assumes EST then Contract 3 would be wrong because it would show on the dashboards as 11/24/2025

When it happened on 11/23/2025 and that local office would count it as 11/23/2025 (not 11/24/2025 EST)

SOLUTION:
DATATEAM cannot assume or have a lazy conversion back. We have to have the source / location of the contract and convert it to their local time zone to address for the "date drift" and use LOCATION-AWARE CONVERSION.

----
In the United States, Daylight Saving Time (DST) is not determined by the weather or the sun directly; it is determined by **Federal Law**, which sets a specific algorithmic rule for the calendar.

Here is exactly how it works, which is critical for your code logic:

### 1. The Algorithm (The Rule)

Since 2007, the rule has been fixed as:

- **Start:** The **second Sunday in March** (Clocks move forward at 2:00 AM).1
- **End:** The **first Sunday in November** (Clocks move back at 2:00 AM).2

### 2. The Source (The Law)

This rule is set by the Energy Policy Act of 2005.3

Before 2007, the dates were different (first Sunday in April to last Sunday in October).4 This matters for data engineering because if you are loading historical data from 2006 or earlier, the "Standard Rule" of today will actually be wrong.

### 3. The Exceptions (The "Location" Logic)

Federal law allows states to **opt out** of DST entirely (stay on Standard Time year-round), but they are not allowed to stay on DST year-round (unless Congress passes a new law).5

This creates the "Exceptions" your code must handle:

- **Arizona:** Does not observe DST (they stay on Mountain Standard Time all year).6 _Exception: The Navajo Nation inside Arizona **does** observe DST._7
    
- **Hawaii:** Does not observe DST.8
    
- **Territories:** Puerto Rico, Guam, US Virgin Islands, and American Samoa do not observe DST.9
    

### Why this breaks "Hard-Coded" Logic

If you write a script that says `IF Date is between March and November THEN subtract 4 hours`, it will fail because:

1. The specific "Sunday" changes every year (it's not always the 10th or 15th).
    
2. It will break for data from Arizona.
    
3. It will break for historical data pre-2007.
    

Best Practice:

This is why we use built-in SQL or Python libraries (like pytz in Python or AT TIME ZONE in SQL). These libraries have a massive internal database called the IANA Time Zone Database that contains the history of every law change and every local exception for every specific location on Earth.

No, Daylight Saving Time is **not** unique to the US, but the **dates are different** for other countries, which adds another layer of complexity to your data.

Here is the "Global Chaos" breakdown for data engineering:

### 1. Europe & UK (Different Schedule)
Most of Europe and the UK use DST, but they switch on different days than the US.
* **US:** Second Sunday in March $\rightarrow$ First Sunday in November.
* **Europe:** Last Sunday in March $\rightarrow$ Last Sunday in October.

**The "Confusion Weeks":**
Because the schedules don't match, there are a few weeks in **March** and **October** where the time difference between New York and London changes.
* *Normally:* 5 hours difference.
* *During the "Gap":* It shrinks to 4 hours (or expands to 6), depending on who switched and who hasn't.

### 2. Southern Hemisphere (Flipped)
Countries like Australia (parts of it) and New Zealand observe DST, but because their seasons are opposite, their clocks are **flipped**.
* **Start:** October (their Spring).
* **End:** April (their Autumn).
* *Data Impact:* While the US is "falling back," Australia is "springing forward."

### 3. The "No DST" Zones
Most of the world actually **does not** use DST.
* **Asia:** China, Japan, India, and most of Asia stay on standard time year-round.
* **Africa:** Most countries do not use DST.
* **Arizona & Hawaii:** As mentioned, parts of the US opt out.

### Why this matters for your "Location-Aware" code
If your company ever expands internationally (or even just processes data from a vendor in London or Sydney), you **cannot** simply check if the date is "between March and November."

You must rely on the **Region Name** (e.g., `'Europe/London'`, `'America/New_York'`) rather than just the offset (e.g., `-5`, `+1`), because the offset is a moving target that changes on different days for different people.