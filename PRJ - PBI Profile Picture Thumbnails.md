For a Proof of Concept (POC), you have two primary paths. Storing images in **SQL Server** as "Varbinary" (BLOBs) is the most robust enterprise method, but the **Base64** method is much faster for a quick local assembly.

Here are the concrete steps for both methods.

---

### Method 1: The SQL Server Path (Enterprise POC)

If you want to simulate a real production environment, store your images in a SQL table.

1. **Create the Table:** Create a table with a column of type `VARBINARY(MAX)` to hold the image data.
2. **Upload Images:** Use a simple SQL script or a tool like SQL Server Management Studio (SSMS) to insert your local files into the table.
3. **Connect Power BI:** Use the **SQL Server database** connector to pull that table into Power BI.
4. **The "Binary to Image" Transformation:** In Power Query (Transform Data), your image column will show up as "Binary".
* To make this viewable, you must convert it to a **Base64 string**.
* Click **Add Column > Custom Column** and use this formula:
`"data:image/jpeg;base64, " & Binary.ToText([YourBinaryColumnName], BinaryEncoding.Base64)`


5. **Set Category:** Once loaded into the model, select the new column and set **Data Category** to **Image URL**.

---

### Method 2: The "Local Folder" Path (Fastest POC)

If you just want to get images from a local folder into Power BI without setting up a database, follow these steps:

1. **Get Data:** In Power BI, select **Get Data > Folder**. Point it to your folder of profile photos.
2. **Transform Data:** In the Power Query editor, you will see a list of files. Keep only the **[Content]** column (which holds the binary data) and perhaps a name column.
3. **Convert to Text:** Use the same Custom Column formula mentioned above:
`"data:image/png;base64, " & Binary.ToText([Content], BinaryEncoding.Base64)`
4. **Handle the Limit:** Power BI has a **32,766 character limit** per cell. If your high-res photos disappear or "break," you must downsize them to thumbnails (under 25KB) before importing, or use a DAX measure to stitch parts of the string together.

---

### Step-by-Step: Displaying them as "Team Thumbnails"

Once your data is in and categorized as an **Image URL**, use the **New Card Visual** to create the "Team" look.

| Step | Action in Format Pane | Result |
| --- | --- | --- |
| **1. Layout** | Set **Layout > Orientation** to Horizontal. | Creates a "row" of teammates. |
| **2. Image** | Select the Image tab, choose your image column, and set **Position** to "Top". | Places photos above names. |
| **3. Shape** | Change Shape to **Rounded Rectangle** and set corners to **50%**. | Turns square photos into circles. |
| **4. Size** | Set **Image > Fit** to "Fill" and adjust size to ~60px. | Ensures a uniform thumbnail size. |

---

### Important Technical Limitations to Remember

* **Sign-in Walls:** Power BI cannot "log in" to see images. This is why local Base64 strings or public URLs work, but direct SharePoint links often fail to render inside the visual.
* **Data Size:** Storing many images as Base64 strings inside your `.pbix` file will increase the file size significantly. For a POC with a small team, this is fine, but for 1,000+ people, the SQL Server "URL" method is better.

**Would you like the specific DAX code to split and re-combine Base64 strings if your images are exceeding the character limit?**