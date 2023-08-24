require_relative '../utils/exceptions'
require_relative '../helpers/model_helper'
require "time"

class Car
  extend ModelHelper

  @@collection = []
  @@filename = "cars.json"
  attr_reader :reg_no, :entry_time, :phone
  attr_accessor :slot_no

  def self.is_valid_reg?(reg_no)
    pattern = /^([A-Za-z]{2}[0-9]{8})$/
    match = reg_no.match? pattern
    raise InvalidRegNo, "Registration number: #{reg_no} is invalid." unless match
    true
  end

  def self.is_valid_phone?(phone)
    pattern = /^\d{10}$/
    match = phone.match?(pattern)
    raise InvalidPhoneNo, "Phone number: #{phone} is invalid." unless match
    true
  end

  def initialize(reg_no: nil, phone: nil, slot_no: nil, entry_time: Time.now.round)
    raise ArgumentError if reg_no.nil? and phone.nil?
    reg_no.nil? ? Car.is_valid_phone?(phone) : Car.is_valid_reg?(reg_no)
    
    already = Car.already?(reg_no || phone)
    raise CarAlreadyParked if already

    @reg_no = reg_no
    @phone = phone
    @slot_no = slot_no
    @entry_time = entry_time
  end

  def self.already?(id)
    !(@@collection.index { |item| item.reg_no == id || item.phone == id }.nil?)
  end

  def self.find(reg_no: nil, phone: nil)
    raise ArgumentError if reg_no.nil? and phone.nil?
    reg_no.nil? ? Car.is_valid_phone?(phone) : Car.is_valid_reg?(reg_no)

    car = @@collection.find { |car| car.reg_no == reg_no && car.phone == phone }
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
    Car.new(
      reg_no: data["reg_no"],
      phone: data["phone"],
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