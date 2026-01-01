- net-new-input
- list-view
- work-view -- logs entry


intake-form -- web app to help triage new consults efficiently; save data for [call-work-queue] later

work-queue -- tickets
	call-work-queue (crm) -- log phone calls


# Call Log
```
I want to create a call-log app. A simplified CRM/salesforce that's focused on quick logging
and on sign off quick metrics

PAGES
1. Summary Login View
2. Account View -- Current STatus Card
	List of Contacts
	Timeline View (Subform  -- can add new log or edit)
		Timestamp | Stage | Call Activity Code | Note 
3. Contact View 
4. Exit Summary
5. Manager View (to be made later)

6. LOAD CALL-WORK-QUEUE
load a list of accounts -- company; phone number; callgroup
	-- loads to centralized database for domains/company
make a call attempt to account.
log note; shortcuts 
	define account.status
	define contact name, position
		auto parses into all field names
		(contact info is all bonus -- not relevant)
	writes to database log
	referred to someone else? 
		referred by -- inhereted by original company + contact at the time
		start a new company or no company = contact name
book a pitch date 
	pitch-status: in-person, video, email+followup
default load a follow up date or select
	2 days; 1 week; custom
log a follow up call + decision
	add a new follow up date
win! log it --> fills close date for account
	adds an invoiceId, invoiceDate
collect payment
adds a paymentId, 
```