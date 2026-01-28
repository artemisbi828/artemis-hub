Static -- fully formed page from server
Dynamic -- JS builds after it loads

### Developer Strategy: How to structure your code

When you write your script (presumably in Python using BeautifulSoup or Selenium), structure it to accept a "Source" switch. This makes moving from your local file to her live environment seamless.

```
from bs4 import BeautifulSoup
import os

# CONFIGURATION SWITCH
# Set to 'LOCAL' for your dev, 'LIVE' for her laptop
MODE = 'LOCAL' 

def get_html_content():
    if MODE == 'LOCAL':
        # Load the file she sent you
        with open('sample_page.html', 'r', encoding='utf-8') as f:
            return f.read()
            
    elif MODE == 'LIVE':
        # Code to fetch from the actual browser/url
        # (e.g., using Selenium driver.page_source)
        pass

# MAIN LOGIC
html_content = get_html_content()
soup = BeautifulSoup(html_content, 'html.parser')

# ... proceed with extraction logic ...
```
### Method 1: The "DevTools" Snapshot (Recommended)

This is the gold standard because it captures the **DOM (Document Object Model)** exactly as it looks _after_ the JavaScript has finished running.

**Instructions for your friend:**

1. Open the webpage and ensure all the data she needs is visible on the screen.
2. Press **F12** (or right-click anywhere and select **Inspect**).
3. A panel will open (usually on the right or bottom). Look for the **Elements** tab.
4. Scroll to the very top of the HTML code in that panel until you see the `<html>` tag.
5. **Right-click** on the `<html>` tag.
6. Select **Copy** > **Copy outerHTML**.
7. Paste that into a Notepad (or Notepad++) file and save it as `sample_page.html`.
8. Send that file to you.
    

**Why this is best:** It bypasses the "empty source code" problem that happens with React, Angular, or Vue.js apps.

### Method 2: "Save Page As" (The Alternative)

If Method 1 is too technical for her, or if the page has a lot of images/styles that you need to see to understand the structure, use the browser's native save.

**Instructions for your friend:**

1. Press **Ctrl + S** (or Command + S on Mac).
2. In the "Save as type" dropdown, select **Webpage, Complete**.
    
    - _Note:_ Do not select "Webpage, HTML Only" unless you are sure it's a static site.
        
3. This will save an `.html` file AND a folder containing images/scripts.
4. She needs to zip both the file and the folder together and send them to you.