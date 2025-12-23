child of [[doc-scraper]]


| **Form Type** | **Priority** | **Complexity** | **Key Challenge**                                                    |
| ------------- | ------------ | -------------- | -------------------------------------------------------------------- |
| **W-2**       | High         | Low            | Layout variations; OCR must detect "Box 1" regardless of position.   |
| **1099-NEC**  | High         | Low            | Differentiating between Payer and Recipient TINs.                    |
| **1099-B**    | Med          | High           | Identifying row delimiters in multi-page brokerage statements.       |
| **1099-R**    | Med          | Med            | Correctly reading the "Distribution Code" (often alphanumeric).      |
| **K-1**       | Low          | High           | Dynamic rows in Part III; text descriptions often accompany numbers. |
