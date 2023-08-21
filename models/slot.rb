require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'

class Slot
  extend ModelHelper

  @@filename = "slots.json"
  @@max_slots = 10
  attr_accessor :occupied, :slot_no

  def initialize(slot_no: , occupied: false)
    @slot_no = slot_no
    @occupied = occupied
  end

  def create_hash
    { slot_no: @slot_no, occupied: @occupied }
  end

  def self.create_object_from_hash(data)
    Slot.new(slot_no: Integer(data["slot_no"]), occupied: data["occupied"])
  end

  def self.init_file
    temp_slots = []
    (1..@@max_slots).each do |i|
      temp_slots << Slot.new(slot_no: i)
    end

    self.write_data_to_file(temp_slots)
  end
end