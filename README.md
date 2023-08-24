# Parking Lot

### Commands

### Help

        ruby path/to/project/runner.rb -h
---
### Park using Registration number

        ruby path/to/project/runner.rb --park-reg <REG_NO>  

example: `ruby ./runner.rb --park-reg AB12345678`

---
### Park using Phone number

        ruby path/to/project/runner.rb --park-phone <PHONE>  

example: `ruby ./runner.rb --park-phone 9876543210`

---
### Unpark using Registration number

        ruby path/to/project/runner.rb --unpark-reg <REG_NO>

example: `ruby ./runner.rb --unpark-reg AB12345678`

---
### Unpark using Phone number

        ruby path/to/project/runner.rb --unpark-phone <PHONE>

example: `ruby ./runner.rb --unpark-phone 9876543210`

---
### List all parked cars

        ruby path/to/project/runner.rb --list-cars

example: `ruby ./runner.rb --list-cars`

---
### List all invoices

        ruby path/to/project/runner.rb --list-invoices

example: `ruby ./runner.rb --list-invoices`

---
### Show a particular invoice

        ruby path/to/project/runner.rb --list-invoice <INVOICE_ID>

example: `ruby ./runner.rb --list-invoice 6`

---
### Print invoice to csv file

        ruby path/to/project/runner.rb --print-csv <INVOICE_ID>

example: `ruby ./runner.rb --print-csv 6`

---
### Print invoice to txt file

        ruby path/to/project/runner.rb --print-txt <INVOICE_ID>

example: `ruby ./runner.rb --print-txt 6`

---
### Print invoice to pdf file

        ruby path/to/project/runner.rb --print-pdf <INVOICE_ID>

example: `ruby ./runner.rb --print-pdf 6`

---
### Mark a slot as inactive

        ruby path/to/project/runner.rb --deactivate-slot <SLOT_NO>

example: `ruby ./runner.rb --deactivate-slot 4`

---
### Mark a slot as active

        ruby path/to/project/runner.rb --activate-slot <SLOT_NO>

example: `ruby ./runner.rb --activate-slot 4`

---
### Add more slots

        ruby path/to/project/runner.rb --add-slots <INCREMENT>

example: `ruby ./runner.rb --add-slots 3`
