class CarView
  def self.list(cars)
    if cars.length == 0
      puts <<END
-----------------------------------------
No car parked at the moment.
-----------------------------------------
END
    else
      cars.each { |car| self.print(car) }
    end
  end

  def self.print(car)
    puts <<END
-----------------------------------------
Car Details
    Registration Number: #{car.reg_no || "N/A"} 
    Phone Number: #{car.phone || "N/A"}
    Parking Slot: #{car.slot_no}
-----------------------------------------
END
  end
end