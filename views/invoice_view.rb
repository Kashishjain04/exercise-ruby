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
      Car Registration Number: #{invoice.car_reg_no || "N/A"}
      Owner Phone Number: #{invoice.car_phone_no || "N/A"}
      Duration: #{
      invoice.duration < 60 ?
        self.duration_in_seconds(invoice.duration) :
        self.duration_in_minutes(invoice.duration)
    }
      Entry: #{invoice.entry_time}
      Exit: #{invoice.exit_time}
      Amount: #{invoice.amount}
------------------------------------------------
    END
  end

  private

  def self.duration_in_seconds(duration)
    duration.to_s + " seconds"
  end

  def self.duration_in_minutes(duration)
    (duration / 60.0).round(2).to_s + " minutes"
  end
end