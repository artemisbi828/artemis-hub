
| **Tool**          | **Formal Definition**                                                               | **The Analogy**                                                                                                                                                                    | **Why for this build?**                                                                                                 |
| ----------------- | ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Vite**          | A modern build tool that serves code via native browser modules during development. | **The Formula 1 Pit Crew.** Instead of rebuilding the entire car every time you change a tire (like older tools), they swap just the tire while the car is moving.                 | It provides near-instant feedback when you tweak your UX copy or layout.                                                |
| **React**         | A library for building user interfaces using isolated, reusable components.         | **LEGO Sets.** You build a "Button" brick and a "Hero" brick once, then snap them together wherever you need them.                                                                 | Keeps the UI modular. If you change your global "Button" style, it updates everywhere.                                  |
| **TypeScript**    | A superset of JavaScript that adds static "types" (definitions) to your data.       | **The Blueprint & Inspector.** It checks that your "Hero" component is actually receiving "Text" and not a "Number" before you even try to run the code.                           | Prevents "broken" states. If a piece of content is missing, the code won't compile, saving you from a broken live site. |
| **Tailwind CSS**  | A utility-first CSS framework that uses predefined classes in HTML.                 | **The Professional Painter’s Palette.** Instead of mixing your own "Blue-ish" paint from scratch every time, you have a set of labeled, consistent colors and brushes ready to go. | Perfect for the "HiHello" look. It forces you to use consistent spacing and colors without a massive CSS file.          |
| **Nginx**         | A high-performance web server and reverse proxy.                                    | **The Maître D’ of a restaurant.** It stands at the door of your Linux VM, takes the customer's request, and serves them the correct static file (your website) instantly.         | It is the most robust way to serve a static site on Linux. It handles high traffic with almost zero CPU usage.          |
| **Framer Motion** | A production-ready motion library for React.                                        | **The Puppeteer.** It tells your React components exactly how to glide, fade, or spring into place.                                                                                | This is how you achieve the "premium" feel of hihello.com—subtle, smooth entrance animations.                           |

# Solid/Dry Structure
my-portfolio/
├── public/              # Raw static assets (favicon, robots.txt)
├── src/
│   ├── assets/          # Images and SVGs used in components
│   ├── components/      # REUSABLE UI units (The "LEGO" bricks)
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   └── Navbar.tsx
│   ├── content/         # YOUR TALKING POINTS (The "Copy" data)
│   │   ├── copy.ts      # The single source of truth for text
│   │   └── projects.ts  # Data for your UX case studies
│   ├── sections/        # PAGE-SPECIFIC LAYOUTS
│   │   ├── Hero.tsx     # Uses copy.ts to fill content
│   │   └── ProjectGrid.tsx
│   ├── styles/          # Global CSS & Tailwind config
│   │   └── index.css
│   ├── App.tsx          # The "Master Assembly" file
│   └── main.tsx         # The entry point for the browser
├── .gitignore           # Files to exclude from GitHub
├── tailwind.config.js   # Design tokens (Colors, Fonts)
├── tsconfig.json        # TypeScript rules
└── vite.config.ts       # Vite configuration



# Inbound Paths
1. Linkedin.com → Reach out [[PRJ - Asheville Leads Ideas|Dewayne Frazier (Nigeria)]] 
	1. → check out website → bitly, score traffic, registered hit 


# Website Navigation 


|                                                                                                                                                                                     |     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| #1 Digital Business Card - Free Forever<br>Your business card should work as hard as you do. Join the millions of people who trust HiHello to make a better impression, every time. | ~   |
|                                                                                                                                                                                     |     |
|                                                                                                                                                                                     |     |
|                                                                                                                                                                                     |     |
|                                                                                                                                                                                     |     |
|                                                                                                                                                                                     |     |
|                                                                                                                                                                                     |     |



# PBI Features
- What are we tracking? 
	- YoY + General KPI Trends w Drilldowns → [Executive Insights]
	- MWD Tracking {Portfolio or LocationGrain} to see key metrics → [Trending Performance]
		- Holiday Name (Panel 1)
		- #status/todo → widen x-axis band (eg dailly) to add more data 
		- Especially → Production Related Metrics
		- MWD → SlicerTypeSort
	- Operations / Drill-down focus for comparison → Ctrl+Select to Multi-Select → [Performance Drill-Down]
	- Scheduling + Conversion
	- Exception Reporting
- Confidence
	- As Of Date -- Data Freshness + Green Checkbox
	- Information Box
- Normalization Buttons → Enterprise Executives
	- Drill Downs
	- [[DAX - Same Store Sales (SSS)|SSS]] --- D_Offices
	- [[DAX - Work Day Equivalent (WDE)|WDE]] -- D_Dates 
- Fast Loads
	- Dashboards vs Reports -- spotlight, focus, fresh
		- Fact Tables are Aggregates
		- Dimensions
		- Everything up stream, using TSQL-views
	- YOY as merged copy of table
	- Copy of F_Table; Rename DateKey → {DateKeyLY, DateKeyRaw} → Add DateKey-Bridge (+1YR) → inner join (pbi-merge) to DateKey



---
#quick-paste-merge-later 

> "I bridge the gap between raw database architecture and executive decision-making. By building normalization frameworks—like **WDE Capacity Scoring** and **Dynamic Same-Store Flags**—I transform high-volume enterprise data into high-integrity insights that survive the 'common sense' test in the boardroom."


### **How to display this on your site:**

I recommend a small "Data Strategy" section with icons for each.

- **WDE Normalization Icon:** A calendar with a scale/balance.
- **Same-Store Icon:** Two identical store-fronts with a "Match" checkmark.
    

### **Suggested "Next Step" for your site:**

Include a call to action like:

> "Most dashboards report what happened; mine report why it happened. Would you like to see how I handle multi-regional holiday logic in global SQL environments?"



>[!Inspo]
>Evan Gagnepain -- Director, Data Engineering and Analytics Led 100+ Employees Managed SIOOM+ budget Increased 65M* Loyalty program v 
Panera Announces-Biggest Menu Transformation in Brand History 
Marketing a Menu Transformation 
Senior Manager, Data Engineering $6B annual revenue Implemented cloud based 
infrastructure 
Feb 2018 - Jun 2023 • 5 yrs 5 mos 
Greater St. Louis Area • Hybrid 
As a senior manager, I directed my team's development efforts using Agile scrum methodolgy and was 
responsible for all data integrations and reporting related to our company operations. 
• Managed the modernization of data warehouse into cloud based data lake 
• Improved operational run time of reports by 90%+ 
• Facilitated cross functional requirements gathering to ensure accurate and complete report development 
• Exposed loyalty and order data in cloud environment enWing advanced ML/AI analytics 
• Implemented both batch and real time data integrations 
Managed team of data engineering professionals who developed novel data integrations in our GCP cloud 
environment and modernized reporting capabilities while maintaining accuracy. 
Skills: Data Architecture • Data Analysis • Data Modeling • Team Management • Databases • Data Engineering 



# Home Page
## Elements
Cookies
```
We value your privacy

We use cookies to give you the best online experience. Cookies keep our site secure and reliable and help us personalize HiHello to you 💜

Customize
Reject All
Accept All
```