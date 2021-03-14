---
kind: article
created_at: "2010-06-2"
title: Automating a very manual Excel Task
---
A client has over 1000 Excel spreadsheets that had been exported from a booking system that the dreaded tax man required.  They had come out of the system in incrementing numbers 0001.xls, 0002.xls etc, one for each day of the previous 3 years of trading.

The taxman however  requested that they be named with the date they represented 23-06-2010.xls for example, and if my client couldn’t provide them in that format they’d be charged for the manual labour of the tax people renaming them.  So they set about opening up each one, finding  the cell that corresponded to the date, closing the spreadsheet, renaming the file, and then moving on to the next one.  In total it took 30 seconds once you were practiced per sheet.

1000 sheets x 30 seconds = 8 hours and 20 minutes, and given the repetitiveness of the task, a likely candidate for manual errors.

This seemed horrendously wasteful to me, so they gave me all the spreadsheets on a USB memory stick, and an hour later I handed it back with all of the sheets renamed correctly for the taxman.  I wrote a small piece of script to open each sheet, select out the right row, and rename the file.  It took 50 minutes to develop and 2 minutes to run.

One happy client, one happy tax man, one chuffed geek.