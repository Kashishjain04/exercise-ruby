require_relative '../utils/exceptions'

class Car
  attr_reader :reg_no, :slot_no, :entry_time

  def self.is_valid?(reg_no)
    pattern = /^([A-Za-z]{2}[0-9]{8})$/
    reg_no.match? pattern
  end

  def initialize(reg_no: , slot_no: , entry_time: Time.now)
    is_valid = Car.is_valid? reg_no
    raise InvalidRegNo, "Registration number: #{reg_no} is invalid." unless is_valid

    @reg_no = reg_no
    @slot_no = slot_no
    @entry_time = entry_time
  end

  def print
    puts <<END
-----------------------------------------
Car Details
    Registration Number: #{@reg_no}
    Parking Slot: #{@slot_no}
-----------------------------------------
END
  end
end