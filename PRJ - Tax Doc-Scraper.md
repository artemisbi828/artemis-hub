child of [[Doc-scraper]]

Form 1099-DIV -- Dividends are your share of a company's profits
Form 1099-B -- sell any stocks, bonds, mutual fund shares, or other investments? We're looking for gains or losses from selling these things


| **Form Type** | **Priority** | **Complexity** | **Key Challenge**                                                    |
| ------------- | ------------ | -------------- | -------------------------------------------------------------------- |
| **W-2**       | High         | Low            | Layout variations; OCR must detect "Box 1" regardless of position.   |
| **1040**      | High         | Low            | US Individual Income Tax Return                                      |
| **8889**      | Med          | Low            | Health Savings Accounts (HSAs)                                       |
| **1099-NEC**  | High         | Low            | Differentiating between Payer and Recipient TINs.                    |
| **1099-B**    | Med          | High           | Identifying row delimiters in multi-page brokerage statements.       |
| **1099-R**    | Med          | Med            | Correctly reading the "Distribution Code" (often alphanumeric).      |
| **K-1**       | Low          | High           | Dynamic rows in Part III; text descriptions often accompany numbers. |

# Other Forms
| **Form Type** | **Priority** | **Complexity** | **Key Challenge**                                                                                                                                                             |
| ------------- | ------------ | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **720**       | Low          |                | Excise Tax: air transportation, tires, gas                                                                                                                                    |
| **1095-A**    | Low          | Low            | It's an important tax form that you'll need if you or a dependent on your tax return got health insurance through the Health Insurance Marketplace (like healthcare.gov).<br> |

Source: Excise Tax for Form 720: Stripe Atlas attempt.


---
#status/deferred/quick-paste-merge-later 
As a tax preparer, I can tell you that building a doc-scraper is a high-ROI project. The bottleneck in tax prep is rarely the math; it is the **data entry** and the **transcription errors** that occur when moving numbers from a messy scan to the tax software.

To build a robust scraper, you need to target the high-volume "source documents" that feed into the Form 1040 (Individual) and 1120/1065 (Business).

Here is the breakdown of the most frequent forms you must handle, categorized by their function in the tax return, along with the critical data points to extract.

---

### 1. Wage & Employment (The Essentials)

These are the most common forms. Almost every individual return will have at least one W-2.

#### **Form W-2 (Wage and Tax Statement)**

_Note: W-2 layouts vary wildly by payroll provider (ADP, Paychex, etc.), but the box numbers are standardized._

- **Entity Data:** Employer Name, Employer EIN, Employee SSN, Employee Name, Employee Address.
- **Box 1:** Wages, tips, other compensation (The most important number).
- **Box 2:** Federal income tax withheld.
- **Box 3 & 4:** Social Security wages & Tax withheld.
- **Box 5 & 6:** Medicare wages and tips & Tax withheld.
- **Box 12:** Codes (A, D, W, DD) and Amounts (Crucial for 401k and HSA data).
- **Box 13:** Checkboxes (Statutory employee, Retirement plan, Third-party sick pay).
- **Box 15-20 (State/Local):** State Abbreviation, Employer State ID, State Wages, State Tax, Local Wages, Local Tax, Locality Name.
    

#### **Form 1099-NEC (Nonemployee Compensation)**

_Replaced Box 7 on the 1099-MISC for independent contractors._

- **Entity Data:** Payer Name/TIN, Recipient Name/TIN.
- **Box 1:** Nonemployee compensation.
- **Box 4:** Federal income tax withheld (Rare, but happens).
- **Box 5-7:** State tax info (State income, Payer state no., State tax withheld).
    

---

### 2. Investment Income

These forms often come in "Composite Statements" from brokerages (like Fidelity or Schwab), which can be 50+ pages long. Your scraper needs to be able to identify distinct tables within a large PDF.

#### **Form 1099-INT (Interest Income)**

- **Box 1:** Interest income.
- **Box 2:** Early withdrawal penalty (Deduction).
- **Box 3:** Interest on U.S. Savings Bonds and Treas. obligations.
- **Box 8:** Tax-exempt interest.
    

#### **Form 1099-DIV (Dividends and Distributions)**

- **Box 1a:** Total ordinary dividends.
- **Box 1b:** Qualified dividends (Taxed at lower rates).
- **Box 2a:** Total capital gain distr.
- **Box 7:** Foreign tax paid (Important for Foreign Tax Credit).
    

#### **Form 1099-B (Proceeds from Broker Transactions)**

_This is the hardest to scrape because it is usually a table with many rows._

- **Per Row Extraction:**
    - Description of property (e.g., "100 shs AAPL").
    - Date acquired (Box 1b).
    - Date sold (Box 1c).
    - Proceeds (Box 1d).
    - Cost or other basis (Box 1e).
- **Wash Sale Loss Disallowed:** (Box 1g) - Crucial to capture.
    

---

### 3. Retirement & Social Security

#### **Form 1099-R (Distributions from Pensions, Annuities, Retirement, etc.)**

- **Box 1:** Gross distribution.
- **Box 2a:** Taxable amount.
- **Box 4:** Federal income tax withheld.
- **Box 7:** Distribution code (Vital logic trigger: Codes 1, 2, 4, 7 change how the tax is calculated).
- **IRA/SEP/SIMPLE Checkbox:** (Indicates if the distribution is from a traditional IRA).
    

#### **Form SSA-1099 (Social Security Benefit Statement)**

- **Box 3:** Description of amount in Box 3 (Gross benefits).
- **Box 5:** Net benefits for the year (This is the number typically entered).
- **Box 6:** Voluntary federal income tax withheld.
    

---

### 4. Deductions, Credits & Health

These forms reduce the tax liability or prove compliance.

#### **Form 1098 (Mortgage Interest Statement)**

- **Box 1:** Mortgage interest received from payer/borrower.
- **Box 5:** Mortgage insurance premiums.
- **Box 10:** Other (Often used for Property Taxes paid through escrow).
    

#### **Form 1098-T (Tuition Statement)**

- **Box 1:** Payments received for qualified tuition.
- **Box 5:** Scholarships or grants.
- **Box 8:** Check if at least half-time student.
    

#### **Form 1095-A (Health Insurance Marketplace Statement)**

_Essential for reconciling the Premium Tax Credit. 1095-B and C are less critical for calculation but good for records._

- **Part III (Monthly Data Columns):**
    - **Column A:** Monthly enrollment premiums.
    - **Column B:** Monthly second lowest cost silver plan (SLCSP).
    - **Column C:** Monthly advance payment of premium tax credit.
        

---

### 5. Pass-Through Entities (Advanced)

If you are automating for high-net-worth clients, you must handle K-1s.

#### **Schedule K-1 (Form 1065 - Partnerships & 1120-S - S Corps)**

- **Part II:** Liability share (Nonrecourse, Qualified nonrecourse, Recourse).
- **Part III (The Matrix):** You need to map the Box Number (left) to the Amount (right).
    - **Box 1:** Ordinary business income/loss.
    - **Box 2:** Net rental real estate income/loss.
    - **Box 4:** Guaranteed payments (1065 only).
    - **Box 5:** Interest income.
    - **Box 17/20:** Alternative Minimum Tax (AMT) items and Other Information codes.
        

---

### Summary Table for Scraper Logic

| **Form Type** | **Priority** | **Complexity** | **Key Challenge**                                                    |
| ------------- | ------------ | -------------- | -------------------------------------------------------------------- |
| **W-2**       | High         | Low            | Layout variations; OCR must detect "Box 1" regardless of position.   |
| **1099-NEC**  | High         | Low            | Differentiating between Payer and Recipient TINs.                    |
| **1099-B**    | Med          | High           | Identifying row delimiters in multi-page brokerage statements.       |
| **1099-R**    | Med          | Med            | Correctly reading the "Distribution Code" (often alphanumeric).      |
| **K-1**       | Low          | High           | Dynamic rows in Part III; text descriptions often accompany numbers. |

### Note on the "1040"

You listed **1040** in your initial list. In tax prep, the 1040 is the _output_, not the input. However, if you are scraping a client's **Prior Year 1040** to bootstrap their file for the current year, you specifically want to extract:

- **Filing Status** (Single, Joint, Head of Household).
- **Dependents** (Names and SSNs).
- **Carryovers** (Capital Loss Carryover, Passive Activity Loss Carryover).
    

Would you like me to generate a JSON Schema example for the W-2 or 1099-NEC to help structure your database?

----
# Setup
## Part 1: Vendor Setup (Google Cloud Document AI)

We will use **Google Cloud Document AI** because it is robust, scalable, and you have an existing account.

### 1. Create/Select a Project

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project (e.g., `tax-doc-scraper-dev`) or select an existing one.
3. **Note the Project ID** (you will need this for the `.env` file).

### 2. Enable APIs

1. In the search bar, type **"Document AI API"**.
2. Click **Enable**.

### 3. Service Account & Credentials

1. Go to **IAM & Admin** > **Service Accounts**.
2. Click **Create Service Account**.
    - Name: `doc-scraper-sa`
3. **Grant Access**:
    - Role: **Document AI API User** (or `Document AI Editor` to be safe for setup).
4. **Create Key**:
    - Click the three dots actions menu for the new service account > **Manage keys**.
    - **Add Key** > **Create new key** > **JSON**.
    - **Save this file** to your workspace root as `service_account_key.json`.
    - WARNING
        
        **Do not commit this file to git.** We will add it to `.gitignore`.
        

### 4. Create Processors

1. Go to **Document AI** in the console.
2. Click **Explore Processors**.
3. **Form Parser** (General):
    - Create a processor named `general-form-parser`.
    - **Copy the Processor ID**.
4. **W-2 Parser** (Specialized - Usage fees apply after free tier):
    - Search for "W-2". Create processor named `w2-parser`.
    - **Copy the Processor ID**.
    - _If you prefer to stay strictly generic, we can use the Form Parser for everything, but the W-2 parser is much more accurate._