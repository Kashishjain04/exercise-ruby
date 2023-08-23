require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'

class Slot
  extend ModelHelper

  @@collection = []
  @@filename = "slots.json"
  @@max_slots = 10
  attr_accessor :car_no, :slot_no

  def initialize(slot_no:, car_no: nil)
    @slot_no = slot_no
    @car_no = car_no
  end

  def self.empty_slot
    empty_slot = @@collection.find { |slot| slot.car_no.nil? }
    raise NoSlotAvailable, "Empty slot not available" if empty_slot.nil?
    empty_slot
  end

  def self.find(slot_no)
    slot = @@collection.find { |slot| slot.slot_no == slot_no }
    raise InvalidSlotId if slot.nil?
    slot
  end

  def park(car)
    self.car_no = car.reg_no
  end

  def unpark
    self.car_no = nil
  end

  def to_hash
    { slot_no: @slot_no, car_no: @car_no }
  end

  def self.initialize_from_hash(data)
    Slot.new(slot_no: Integer(data["slot_no"]), car_no: data["car_no"])
  end

  def self.init_file
    temp_slots = []
    (1..@@max_slots).each do |i|
      temp_slots << Slot.new(slot_no: i)
    end

    self.write_data(temp_slots)
  end
end