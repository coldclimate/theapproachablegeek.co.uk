---
kind: article
created_at: "2011-05-12"
title: Automating an Estate Agent with Excel
---
(and almost getting an alliterating title too)

I’ve just finished a short project with a Newcastle Upon Tyne based estate agent, helping to smooth over some of their accounting and records processes. Previously they had to manually reconcile their bank statements against each room in every property they had, and then reorganise this information by tenant to work out who’s not paid their rent for this month.

This now all happens in a single spreadsheet (or rather a single workbook with multiple spreadsheets), which are set up annually, and amended daily. Bank statements are imported from [LLoydsLink](http://www.lloydsbankcorporatemarkets.com/Online-Services/), each payment is allocated to a tenant though a series of drop down menus (pick a property and it refines the options for tenants to just those living in that property). All the following calculations are derived from this data, mostly using the extremely powerful [Pivot Table](http://en.wikipedia.org/wiki/Pivot_table) (and a few extra functions).

Pivot Tables make it easy to take a stack of tabular data and to group and filter specific columns based on the values of other columns. It’s uses are endless from summarising sales data to digging out nuggets of insight which are buried in the morass of information.

For the total cost of about three days of my time we’ve saved approximately 10 hours a week of admin time, as well as hugely reducing the chances of manual error.


