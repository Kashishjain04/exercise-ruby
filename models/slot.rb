require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'

class Slot
  extend ModelHelper

  @@collection = []
  @@filename = "slots.json"
  @@max_slots = 10
  attr_accessor :car_id, :slot_no, :active

  def initialize(slot_no:, car_id: nil, active: true)
    @slot_no = slot_no
    @car_id = car_id
    @active = active
  end

  def self.empty_slot
    empty_slot = @@collection.find { |slot| slot.car_id.nil? && slot.active }
    raise NoSlotAvailable, "Empty slot not available" if empty_slot.nil?
    empty_slot
  end

  def self.find(slot_no)
    slot = @@collection.find { |slot| slot.slot_no == slot_no }
    raise InvalidSlotId if slot.nil?
    slot
  end

  def park(car_id)
    self.car_id = car_id
  end

  def unpark
    self.car_id = nil
  end

  def to_hash
    { "slot_no"=>@slot_no, "car_id"=>@car_id, "active"=>@active }
  end

  def self.initialize_from_hash(data)
    Slot.new(
      slot_no: Integer(data["slot_no"]),
      car_id: data["car_id"],
      active: data["active"]
    )
  end

  def self.init_file
    temp_slots = []
    (1..@@max_slots).each do |i|
      temp_slots << Slot.new(slot_no: i)
    end

    self.write_data(temp_slots)
  end

  def mark_inactive
    raise SlotActive, "Slot not active" unless @active
    @active = false
  end

  def mark_active
    raise SlotActive, "Slot already active" if @active
    @active = true
  end

  def self.increase_slots(increment)
    ctr = @@collection.length
    new_slots = (1..increment).map do
      ctr+=1
      Slot.new(slot_no: ctr)
    end

    (@@collection << new_slots).flatten!
  end
end