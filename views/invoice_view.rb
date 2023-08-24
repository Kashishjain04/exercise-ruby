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
    puts invoice.text_content
  end

  def self.saved_to(path)
    puts <<END
------------------------------------------------
Your invoice is saved to:
#{path}
------------------------------------------------
END
  end
end