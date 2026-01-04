### 1. The "OneNote Feel" (Automatic Attachments)

In OneNote, you don't care where the image lives. In Obsidian, if you don't configure it, your sidebar gets cluttered with `Pasted image 123.png` files.

**The Fix:** Create a dedicated "Junk Drawer" for your images so they don't clutter your notes list.

1. Create a folder named `Attachments` (or `Files`).
2. Go to **Settings** > **Files & Links**.
3. Change **"Default location for new attachments"** to **"In the folder specified below"**.
4. Select your `Attachments` folder.

**Now:** When you `Ctrl + V`, the image disappears into that folder and the `![[]]` link appears in your note instantly. You never have to see the actual file again.

---

### 2. View vs. Edit (The Visual Gap)

If you are seeing the code `![[Pasted image...]]` instead of the picture, you are likely in **Source Mode**.

- **The Fix:** Ensure you are in **Live Preview**.
- Look for the "fountain pen" icon or click the three dots in the top right.
- In Live Preview, the moment you paste, the code disappears and the image renders immediately, just like OneNote.

### 3. Pro Tip: Managing Image Size

OneNote lets you click and drag to resize. In Obsidian, you do it via the link. It’s not as "mouse-friendly," but it’s very fast once you know the syntax:

- **Standard:** `![[image.png]]`
- **Resized (Width in pixels):** `![[image.png|300]]`
    

> [!TIP]
> 
> The "Image Capturing" Workflow
> 
> If you want to get even closer to the OneNote experience, use the "Image Toolkit" or "Paste Image Rename" community plugins. They allow you to rename the image the moment you paste it so your files stay organized without extra effort.
