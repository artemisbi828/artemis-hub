Related To: [[DAX]], [[DAXM]], [[DAXQ]], [[TMDL]]
# Setup + Presentation
[[PBI - Standards]]
[[PBI - Colors]]
[[PBI - Deployment Checklist]]
[[PBI - GIT - AZD to AZP Promotion]]
[[PBI - GIT Troubleshooting]]
# Data Modeling + Sql Views
[[DAX - Planning the Grain]]
[[DAX - Data Modeling]]
[[DAX- Refresh Box]]
[[DAX - Same Store Sales (SSS)]]
[[DAX - Work Day Equivalent (WDE)]]
# INIT 
[[DAX - New Builds]]
[[DAX - Checkbox]]
[[DAX - Add Sort By Column]]
[[DAX - Slicers, Panels, Selection Groups]]
[[DAX - Matrix - Column Headers]]

[[PBI - Embed Report]]


# Future Projects
[[PRJ - PBI Data Dictionary]]
[[PRJ - PBI Profile Picture Thumbnails]]

[[DAX - UDF (Research)]]

![[Pasted image 20260110195401.png]]
Based on the screenshot provided, I have extracted the color palette, typography styles, and container formatting (rounded corners and borders) to create this JSON theme file.

You can copy this code into a text editor (like Notepad), save it as a **`.json`** file, and import it into Power BI via **View > Themes > Browse for themes**.

### The "Power UI" Inspired JSON Template

```json
{
    "name": "PowerUI_Emulation",
    "dataColors": [
        "#0072FF", 
        "#9027FE", 
        "#FF007E", 
        "#00C272", 
        "#FFB900", 
        "#FF7300", 
        "#00D1FF", 
        "#8E8E93"
    ],
    "visualStyles": {
        "*": {
            "*": {
                "background": [{
                    "show": true,
                    "color": { "solid": { "color": "#FFFFFF" } },
                    "transparency": 0
                }],
                "border": [{
                    "show": true,
                    "color": { "solid": { "color": "#E6E6E6" } },
                    "radius": 12
                }],
                "visualHeader": [{
                    "show": true,
                    "background": { "solid": { "color": "#FFFFFF" } },
                    "border": { "solid": { "color": "#FFFFFF" } }
                }],
                "title": [{
                    "show": true,
                    "fontColor": { "solid": { "color": "#252423" } },
                    "fontSize": 12,
                    "fontFamily": "Segoe UI Semibold"
                }]
            }
        },
        "page": {
            "*": {
                "background": [{
                    "color": { "solid": { "color": "#F8F9FA" } },
                    "transparency": 0
                }]
            }
        },
        "columnChart": {
            "*": {
                "categoryAxis": [{ "show": true, "labelColor": { "solid": { "color": "#666666" } } }],
                "valueAxis": [{ "show": true, "gridlineShow": true, "gridlineColor": { "solid": { "color": "#F0F0F0" } } }]
            }
        },
        "areaChart": {
            "*": {
                "plotArea": [{ "transparency": 80 }]
            }
        }
    },
    "textClasses": {
        "label": { "fontFamily": "Segoe UI", "fontSize": 10, "color": "#666666" },
        "callout": { "fontFamily": "Segoe UI Bold", "fontSize": 24, "color": "#252423" },
        "title": { "fontFamily": "Segoe UI Semibold", "fontSize": 14, "color": "#252423" }
    }
}

```

---

### Design Elements Decoded from your Screenshot:

* **The "Card" Container:** The most distinct element is the white container with a **12px rounded corner radius** and a very light gray border (`#E6E6E6`). This creates that clean "App-like" feel.
* **The Palette:**
* **Action Blue:** `#0072FF` (Used in bar charts and primary lines).
* **Vibrant Purple:** `#9027FE` (The secondary category color).
* **Accent Pink:** `#FF007E` (Used for specific callouts or high-contrast segments).
* **Success Green:** `#00C272` (Used for the Sales Amount growth indicator).


* **Background Contrast:** The page background is set to a very subtle off-white (`#F8F9FA`) to make the white visual cards "pop."
* **Typography:** The template uses **Segoe UI Semibold** for titles and a muted gray (`#666666`) for labels and axes to reduce visual noise.
* **Area Transparency:** The Area Charts in your screenshot have a soft, semi-transparent fill. I've set the default `plotArea` transparency to **80%** to emulate that "misty" look.

### How to refine this further:

While the JSON handles the containers and colors, the **KPI layouts** (like the green dollar amount with the goal underneath) are best handled using the **New Card Visual** in Power BI.

**Would you like me to explain how to set up the "New Card Visual" to match the specific layout shown in your Sales Amount cards?**