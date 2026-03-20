1. use call outs
2. read this more https://minimal.guide/home -- Calendar, 


**Style Settings (Plugin):** This is the gold standard. It provides a menu to change colors, font sizes, and weights for headings, bold text, and code blocks without touching any code.
    
- **Minimal Theme:** Pair Style Settings with the **Minimal** theme. It’s the most popular theme for a reason: it’s clean, and when combined with the **Minimal Theme Settings** plugin, you can enable "Colorful Headings" to make H1–H6 instantly distinct.
    
- **AnuPpuccin (Theme):** If you find Minimal too plain, AnuPpuccin offers vibrant, high-contrast dark modes that make bold text and code pop much more naturally.

## 2. Specialized Plugins for Formatting

For the specific issues you mentioned, these plugins are game-changers:

|**Feature**|**Recommended Plugin**|**What it does**|
|---|---|---|
|**Code Visibility**|**Code Styler**|Allows you to add background colors, border-radii, and "language icons" to code blocks. It makes them look like professional snippets rather than just grey boxes.|
|**Heading Hierarchy**|**Better Heading Hierarchy**|Adds subtle guide lines or indentation to help you see exactly which section a paragraph belongs to.|
|**Heading Levels**|**Lapel**|Adds the heading level (H1, H2, etc.) in the left margin (gutter) so you can tell them apart at a glance.|
|**Bold/Highlighting**|**Editing Toolbar**|Adds a floating MS Word-style toolbar. Useful if you want to quickly apply different colors to text to make it "pop" more than standard bolding.|

---

## 3. The "CSS Snippet" Shortcut (No Plugin Needed)

Sometimes a plugin is overkill. You can fix bold text and headers by pasting a tiny bit of code into **Settings > Appearance > CSS Snippets**.

**To make Bold text "Glow" or change color in Dark Mode:**

CSS

```
.theme-dark strong {
  color: #ff9e64; /* A bright orange/peach that stands out */
  font-weight: 800;
}
```

**To make Code Blocks more visible:**

CSS

```
.theme-dark code {
  background-color: #2e3440; /* Darker navy background */
  color: #a3be8c; /* Light green text */
  padding: 2px 4px;
}
```

# Ian's Obsidian
---

## First: baseline (what comes with Obsidian by default)

Out‑of‑the‑box Obsidian icons usually include things like:

- File Explorer (folder)
- Search (magnifying glass)
- Graph view (node network)
- Backlinks
- Tags
- Outline
- Calendar (if enabled, but now core)

Your screenshot **goes far beyond this**, so let’s focus on the _non‑core_ ones.

---

## Interpreting the screenshot (top → bottom)

I’ll number icons **top to bottom**, describing the exact visual and mapping to likely plugins.

---

### 1. ☰☰ (stacked horizontal bars / checklist-style icon)

✅ **Advanced Tables** _or_ **Custom View launcher**

**Most likely:**

- **Advanced Tables** (very common power-user plugin)

Why:

- Frequently used
- Icon often looks like rows/lists
- Shows up near the top in many setups

---

### 2. Page with user silhouette

✅ **Metadata Menu** _or_ **Templater-related UI**

**Most likely:**

- **Metadata Menu**

Why:

- Profile/user silhouette is commonly used to represent _frontmatter editing_
- Metadata Menu adds a sidebar icon exactly like this

---

### 3. Connected nodes / branching dots

✅ **Local Graph** _(core)_ OR **Juggl**, **Neo4j Graph View**

If this icon is **different from Obsidian’s default graph**, then:

**Most likely:**

- **Juggl** (graph + relationships plugin)

Juggl uses a _node connection_ icon distinct from the core graph.

---

### 4. Four rounded squares (grid)

✅ **Dataview**

This one is high confidence.

- Grid / table symbol
- Extremely common
- Almost always present in “heavy” Obsidian setups

✅ **Get this plugin immediately if you don’t have it**

---

### 5. Overlapping pages

✅ **Templater**

Very high confidence.

- Multiple documents stacked
- Exact icon Templater uses by default

---

### 6. `>_` terminal-style caret

✅ **Shell Commands** _or_ **Code Runner**

Most likely:

- **Shell Commands**

Why:

- Power users use it
- Icon often resembles CLI / execution

---

### 7. Person with sliders

✅ **Settings Search** _or_ **Quick Switcher++**

Most likely:

- **Quick Switcher++**

The “tuning controls” + user metaphor strongly suggests navigation enhancement.

---

### 8. Briefcase / toolbox-looking icon

✅ **Projects**

Very high confidence.

- Projects plugin icon looks exactly like this
- Allows folder → project workflows

✅ Strong recommendation if you work across domains.

---

### 9. Screen / monitor

✅ **Workbench** _or_ **Kanban board view**

Most likely:

- **Kanban** (community plugin)

Especially if colleague uses task boards.

---

### 10. ID card / card with text lines

✅ **Kanban** (alternate icon) or  
✅ **CardBoard** / **CardView**

Some setups expose **multiple views for cards**.

---

### 11. Branch with dots AND cog overlay

✅ **Git**

✅ **Very high confidence**

- Obsidian Git plugin icon
- Branch + settings is a dead giveaway

✅ Essential if you version your notes.

---

### 12. Sun / brightness icon

✅ **Day Planner** _or_ **Theme Switcher**

More likely:

- **Day Planner**

Especially common with work-journal users.

---

### 13. `</>` code brackets

✅ **CodeMirror Options** _or_ **Custom JS / Snippets runner**

Most likely:

- **CustomJS** plugin

---

### 14. Database / table

✅ **Database Folder**

Very high confidence.

- Cylindrical DB icon
- Popular among people pushing Obsidian toward “Notion-like” behavior

---

### 15. Calendar (non-core position)

✅ **Calendar** (community version or enhanced calendar)

Often appears duplicated alongside Day Planner.

---

### 16. Filing cabinet

✅ **Archive** _or_ **File Tree Alternative**

Less certain, but likely:

- **Obsidian Archive**
- **File Notes**

---

### 17. Chain / link

✅ **Backlink Helper** _or_ **Link Explorer**

Enhanced backlink/navigation plugin.

---

### 18. Home icon

✅ **Homepage**

Very high confidence.

- Dedicated plugin
- Lets vault open to a specific note/dashboard

---

### 19. Wrench with lightning

✅ **Commander**

✅ **Extremely high confidence**

- Commander lets you add commands to UI
- Icon matches perfectly

✅ This is a _keystone_ power-user plugin.

---

### 20. Bug / wrench combo

✅ **Debug Tools** _or_ **Plugin Dev Tools**

Likely:

- **Developer Tools plugin**
- Used by advanced users who customize JS/CSS

---

## High‑confidence “must install” list (start here)

If your goal is **closest parity** with your colleague, install these first:

1. **Dataview**
2. **Templater**
3. **Metadata Menu**
4. **Obsidian Git**
5. **Commander**
6. **Projects**
7. **Database Folder**
8. **Quick Switcher++**
9. **Kanban**
10. **Day Planner**

---

## Want to be precise?

Two ways to 100% confirm:

1. **Hover over each icon** in your colleague’s Obsidian → tooltip shows plugin name
2. Ask them for:
    - `.obsidian/plugins/` directory screenshot
    - OR exported `community-plugins.json`

If you want, you can:

- Paste their plugin list here
- Or upload a higher‑resolution screenshot

…and I’ll **normalize + prioritize** it into:

- “Core productivity”
- “Data modeling”
- “UI acceleration”
- “Overkill / niche”

You’re clearly already an advanced user — this setup is _very_ aligned with BI / systems thinking.