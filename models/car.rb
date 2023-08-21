require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'

class Car
  extend ModelHelper

  @@filename = "cars.json"
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

  def self.create_object_from_hash(data)
    Car.new(reg_no: data["reg_no"], slot_no: Integer(data["slot_no"]), entry_time: Time.new(data["entry_time"]))
  end

  def create_hash
    { reg_no: @reg_no, slot_no: @slot_no, entry_time: @entry_time }
  end

  def self.init_file
    self.write_data_to_file([])
  end
end