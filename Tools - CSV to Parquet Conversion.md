related-to: [[Tools - DuckDB]]

Since you already have DuckDB installed on your machine, you have access to what is universally considered the absolute fastest, most efficient CSV-to-Parquet converter on the market.

Because DuckDB handles streaming data using a low-level vectorized engine, it can stream massive CSV files directly into compressed, highly optimized Parquet format while barely touching your computer's memory.

Here are the best ways to do it locally, depending on whether you want to use a quick command-line snippet or a Python script.

---

## Method 1: The Quick DuckDB CLI / DataGrip Query (Fastest)

If you have a local CSV file, you don't even need to open a permanent database session. You can pass a single line of SQL directly to the `duckdb.exe` binary in your terminal, and it will handle the conversion out-of-process.

Run this command in your normal terminal (or type the SQL portion inside your DataGrip query console):

```bash
duckdb -c "COPY 'C:/data/source_file.csv' TO 'C:/data/output_file.parquet' (FORMAT 'PARQUET', COMPRESSION 'ZSTD');"

```

### Why this is robust:

* **Streaming Engine:** If your CSV is 20GB and your computer only has 16GB of RAM, this query will **not** crash. DuckDB automatically chunks and streams the data, writing blocks out to disk continuously.
* **`ZSTD` Compression:** By specifying `COMPRESSION 'ZSTD'`, you are using a modern industry-standard codec that achieves massive file size reductions (often shrinking a CSV down by 70–90%) while maintaining incredibly high unzip speeds.

---

## Method 2: The DuckDB Python Script (Best for Automation)

If you want to build this conversion step into your local automation pipelines before feeding the files into **SQLMesh**, you can write a tiny Python script.

You don't need to import Pandas or Polars. Just let Python call the underlying C++ DuckDB engine directly:

```python
import duckdb

def convert_csv_to_parquet(csv_path, parquet_path):
    # Initialize a clean, transient in-memory connection
    conn = duckdb.connect()
    
    # Run the streaming copy command
    conn.execute(f"""
        COPY '{csv_path}' 
        TO '{parquet_path}' 
        (FORMAT 'PARQUET', COMPRESSION 'ZSTD');
    """)
    print(f"Successfully converted {csv_path} to {parquet_path}")

# --- Example Usage ---
csv_in = "C:/data/transactions.csv"
parquet_out = "C:/data/transactions.parquet"

convert_csv_to_parquet(csv_in, parquet_out)

```

---

## Advanced Optimization: Cleaning Data During Conversion

One of the biggest flaws with standard CSV converters (like Python Pandas) is that they try to guess data types based on the first few thousand rows. If a column looks like an integer early on but contains a string on row 500,000, the converter crashes or corrupts the data.

Because DuckDB lets you inspect and manipulate data *as* it converts, you can explicitly clean up and format your columns on the fly.

For example, if your CSV has a messy date string or an implicit casing structure you want to fix before it reaches your final storage layer, you can transform it mid-flight:

```sql
COPY (
    SELECT 
        id,
        -- Convert a messy text date (MM/DD/YYYY) to a true strict SQL DATE type
        strptime(raw_date_column, '%m/%d/%Y')::DATE AS execution_date,
        -- Enforce strict lowercase naming normalization on your text data
        lower(division_name) AS division_name,
        CAST(sales_amount AS DECIMAL(18, 2)) AS sales_amount
    FROM 'C:/data/raw_input.csv'
) TO 'C:/data/clean_output.parquet' (FORMAT 'PARQUET', COMPRESSION 'ZSTD');

```

This ensures that the outputted Parquet file is completely clean, perfectly typed, heavily compressed, and ready to be safely attached or queried by SQLMesh with zero downstream parsing friction.