when you create adjustment+breakout entries
-- 1 -- back out the total
-- 2 -- add back in the line items individually


INVOICE -- does not need a contract
	InvoiceKey!
	CreatedDateTime
	CreatedBy
	DueDate -- by endofdate
	~TotalAmount -- calc

INVOICE DETAILS -- secondary fact w/ change tracking
	InvoiceDetailKey!
	CreatedDateTime
	CreatedBy
	InvoiceKey.
	ProductServiceKey.
	Amount
	Description
	DeleteDateTime
	DeletedBy
