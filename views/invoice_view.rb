class InvoiceView
  def self.list(invoices)
    if invoices.length == 0
      puts <<END
-----------------------------------------
No invoice generated till now.
-----------------------------------------
END
    else
      invoices.each { |invoice| self.print(invoice) }
    end
  end

  def self.print(invoice)
    puts <<-END
------------------------------------------------
Your Invoice: ##{invoice.invoice_id}
      Car Registration Number: #{invoice.car_reg_no}
      Duration: #{ invoice.duration < 60 ? invoice.duration.to_s + " seconds" : (invoice.duration / 60.0).round(2).to_s + " minutes" }
      Entry: #{invoice.entry_time}
      Exit: #{invoice.exit_time}
      Amount: #{invoice.amount}
------------------------------------------------
    END
  end
end