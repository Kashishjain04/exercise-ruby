require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'
require "time"

class Car
  extend ModelHelper

  @@collection = []
  @@filename = "cars.json"
  attr_reader :reg_no, :entry_time, :phone
  attr_accessor :slot_no

  def self.is_valid?(reg_no)
    pattern = /^([A-Za-z]{2}[0-9]{8})$/
    match = reg_no.match? pattern
    raise InvalidRegNo, "Registration number: #{reg_no} is invalid." unless match
    true
  end

  def self.id_is_phone(id)
    pattern = /^\d{10}$/
    id.match?(pattern)
  end

  def initialize(id:, slot_no: nil, entry_time: Time.now.round)
    is_phone = Car.id_is_phone(id)
    Car.is_valid? id unless is_phone

    already = Car.already?(id)
    raise CarAlreadyParked if already

    @reg_no = is_phone ? nil : id
    @phone = is_phone ? id : nil
    @slot_no = slot_no
    @entry_time = entry_time
  end

  def self.already?(id)
    !(@@collection.index { |item| item.reg_no == id || item.phone == id }.nil?)
  end

  def self.find(id)
    is_phone = id_is_phone(id)
    Car.is_valid? id unless is_phone

    car = @@collection.find { |car| car.reg_no == id || car.phone == id }
    raise CarNotFound if car.nil?

    car
  end

  def park(slot_no)
    self.slot_no = slot_no
    @@collection << self
  end

  def unpark
    @@collection.delete_if { |item| item.object_id == self.object_id }
  end

  def self.initialize_from_hash(data)
    id = data["reg_no"].nil? ? data["phone"] : data["reg_no"]
    Car.new(
      id: id,
      slot_no: data["slot_no"].nil? ? nil : Integer(data["slot_no"]),
      entry_time: Time.parse(data["entry_time"])
    )
  end

  def to_hash
    { "reg_no"=>@reg_no, "phone"=>@phone, "slot_no"=>@slot_no, "entry_time"=>@entry_time.to_s }
  end

  def self.init_file
    self.write_data([])
  end
end