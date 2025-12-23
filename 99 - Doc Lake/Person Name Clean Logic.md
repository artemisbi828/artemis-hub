---
domain: logic
---
- remove trailing and leading spaces
- "Dr. María-Jose de la Cruz y Benavides-Smith "The Hammer" III, Esq."

**Breakdown of valid fields:**

- **Title:** Dr.
- **First Name:** María-Jose (Hyphenated compound)
- **Middle/Composite:** de la Cruz (Particle based)
- **Last Name:** y Benavides-Smith (Compound with conjunction and hyphen)
- **Nickname:** "The Hammer"
- **Suffix:** III
- **Post-Nominal:** Esq.
### 1. The "Unhyphenated Double Surname"

- **The Name:** `Helena Bonham Carter`
- **The Challenge:** Without a hyphen, a parser will almost always identify "Bonham" as a middle name. However, her surname is "Bonham Carter."
- **Similar:** `Sacha Baron Cohen`, `Andrew Lloyd Webber`
    

### 2. The "Complex Particle" (Tussenvoegsels)

- **The Name:** `Ursula von der Leyen`
- **The Challenge:** Is the last name "Leyen"? "der Leyen"? or "von der Leyen"? In many databases, "von" and "der" are treated as distinct particles that might lower-case, while the sortable surname is "Leyen."
- **Similar:** `Vincent van Gogh`, `Ludwig van Beethoven`, `Olivia de Havilland`
    

### 3. The "Hispanic Compound"

- **The Name:** `Gabriel José de la Concordia García Márquez`
- **The Challenge:** Spanish naming customs often use two surnames (Paternal + Maternal). "García" is the paternal (primary) surname, and "Márquez" is the maternal. A standard parser usually grabs the very last word ("Márquez") as the primary last name, which is incorrect for sorting.
- **Similar:** `Oscar de la Hoya`, `Benicio del Toro`
    

### 4. The "Embedded Nickname & Suffix"

- **The Name:** `Gen. H. Norman "Stormin' Norman" Schwarzkopf Jr.`
- **The Challenge:** This contains five distinct elements: Title (`Gen.`), Initial (`H.`), Middle (`Norman`), Nickname (`"Stormin' Norman"`), Surname (`Schwarzkopf`), and Suffix (`Jr.`). Detecting where the name actually starts and ends is difficult.
- **Similar:** `Dwayne "The Rock" Johnson`, `George Herman "Babe" Ruth`
    

### 5. The "Compound First Name"

- **The Name:** `Mary Anne MacLeod`
- **The Challenge:** Is "Anne" a middle name? In this case, "Mary Anne" is the full first name. A parser splitting by space will incorrectly assign "Anne" to the Middle Name field.
- **Similar:** `Jean-Luc Picard` (Easier due to hyphen), `Billy Bob Thornton`
    

### 6. The "Reverse Order" (Asian Naming Customs)

- **The Name:** `Mao Zedong`
- **The Challenge:** In many East Asian cultures, the family name comes first. "Mao" is the surname, "Zedong" is the given name. If parsed by Western standards, "Zedong" becomes the surname.
- **Similar:** `Yao Ming`, `Kim Jong Un`
    

### 7. The "Mononym"

- **The Name:** `Zendaya`
- **The Challenge:** Many databases require a non-null "Last Name" field. Mononyms cause validation errors or result in names like "Zendaya ." or "Zendaya LNU" (Last Name Unknown).
- **Similar:** `Cher`, `Plato`, `Teller`
    

### 8. The "Post-Nominal Soup"

- **The Name:** `Martin Luther King, Jr., Ph.D., D.D.`
- **The Challenge:** Distinguishing between generational suffixes (Jr., III) and professional/academic titles (Ph.D., Esq., MD) often requires a hard-coded lookup table.