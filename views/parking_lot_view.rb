class ParkingLotView
  def self.park(slot_no)
    puts "Park your car at slot number: #{slot_no}"
  end

  def self.unpark(slot_no, invoice_id)
    puts <<END
Take your car from slot number: #{slot_no}
------------------------------------------------
Your invoice is generated with invoice_id: #{invoice_id}
END
  end
end