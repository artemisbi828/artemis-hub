[[Tools - Python]]

Since you are a SQL Server developer, the fastest way to understand a **Parquet** file is this:

**A Parquet file is essentially a portable, single-file Clustered Columnstore Index.**

If you understand how a Columnstore Index works in SQL Server, you already understand 90% of Parquet. Here is the translation guide:

### 1. The Core Concept: Row vs. Column

- CSV / Standard SQL Table (Row Store):

    Imagine a bookshelf where you store books by author. If you want to find the average price of all books, you have to pull every book off the shelf, open it, check the price, and put it back. You touch a lot of data you don't need (Title, Author, ISBN) just to get the Price.
    
- Parquet (Column Store):

    Imagine you tear the pages out of the books. You staple all the "Price" pages together into one folder. You staple all the "Author" pages into another. Now, to get the average price, you just grab the "Price" folder. You ignore everything else.
    

### 2. The Structural Mapping (SQL vs. Parquet)

Here is how the physical structure of a Parquet file maps to the SQL Server internals you know:

|**SQL Server Concept**|**Parquet Concept**|**Why it matters**|
|---|---|---|
|**Clustered Columnstore Index**|**Parquet File**|Both store data column-by-column, not row-by-row.|
|**Rowgroup / Batch**|**Row Group**|Parquet breaks data into horizontal slices (e.g., every 10,000 rows). It stores these groups independently.|
|**Segment**|**Column Chunk**|Inside a Row Group, the data for _Column A_ is stored together in one chunk.|
|**Header / Statistics**|**Footer (Metadata)**|The end of the file has a "map" that says: _"The 'Date' column in Row Group 1 has values from Jan 1 to Jan 5."_|

### 3. Why Parquet is "Smart" (The Magic of the Footer)

In a CSV, if you want row 1,000,000, you have to read the 999,999 rows before it. The computer has no idea where the data is.

In Parquet, there is a **Footer** at the end of the file. When a tool (like Fabric, Pandas, or Power BI) opens a Parquet file, it reads the footer _first_.

The footer contains **Min/Max statistics** for every column in every Row Group.

- **The Scenario:** You run `SELECT * FROM File WHERE Date = '2023-12-01'`
- **The Action:** The engine looks at the footer.
    - Row Group 1: Min Date '2023-01-01', Max Date '2023-01-31'. -> **SKIP (Predicate Pushdown)**
    - Row Group 2: Min Date '2023-11-01', Max Date '2023-12-31'. -> **READ**
- **The Result:** It only reads the chunks of the file that actually matter. This is why it is so much faster than CSV.
    

### 4. Data Types (The "Gotcha")

In SQL Server, you have strict types (VARCHAR, NVARCHAR, DATETIME2).

In CSV, everything is a string. You lose your types.

In Parquet, types are preserved.

- It knows the difference between an Integer and a String.
- **Warning:** Parquet has fewer specific types than SQL. For example, SQL has `TinyInt`, `SmallInt`, `Int`, `BigInt`. Parquet often just simplifies these to `Int32` or `Int64`. When moving data back and forth, you occasionally have to cast types explicitly.
    

### 5. Why this speeds up your local work

Because you are used to SSMS, you are used to the server doing the heavy lifting. When you work locally with Python/Pandas:

1. **Compression:** Parquet files are usually 10x smaller than the equivalent CSV. A 1GB CSV might be a 100MB Parquet file. This fits easily in your RAM.
2. **I/O Savings:** If you only load 3 columns out of 50 in your Pandas script (`pd.read_parquet('file.parquet', columns=['A','B','C'])`), it literally never reads the other 47 columns from the disk. It jumps right over them.
    

### Summary for the SQL Dev

- **It's a detached Columnstore Index.**
- **It has "Statistics" built-in (Min/Max in the footer).**
- **It supports "Index Seeks" (Row Group skipping).**
    

Would you like to see a quick snippet of how to "inspect" this metadata (the footer) using Python, so you can see the Min/Max stats for yourself?