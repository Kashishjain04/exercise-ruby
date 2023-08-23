require "time"
require_relative '../helpers/model_helper'

class Invoice
  extend ModelHelper

  @@collection = []
  @@filename = "invoices.json"
  attr_accessor :car_reg_no, :slot_no, :entry_time, :exit_time, :duration, :amount, :invoice_id

  def initialize(car_reg_no:, slot_no:, entry_time:, exit_time:, duration: nil, amount: nil)
    @car_reg_no = car_reg_no
    @slot_no = slot_no
    @entry_time = entry_time
    @exit_time = exit_time
    @duration = Integer(exit_time - entry_time)
    @amount = calc_amount
    @invoice_id = @@collection.length + 1

    @@collection << self

    @invoice_id
  end

  def calc_amount
    price_mapping = { ..10 => 100, 11..30 => 200, 31..60 => 300, 61.. => 500 }
    price_mapping.each { |range, value| return value if range === @duration }
  end

  def self.find(invoice_id)
    invoice = @@collection.find { |invoice| invoice.invoice_id == invoice_id }
    raise InvoiceNotFound if invoice.nil?

    invoice
  end

  def self.initialize_from_hash(data)
    Invoice.new(
      car_reg_no: data["car_reg_no"],
      slot_no: Integer(data["slot_no"]),
      entry_time: Time.parse(data["entry_time"]),
      exit_time: Time.parse(data["exit_time"]),
      duration: Integer(data["duration"]),
      amount: Integer(data["amount"])
    )
  end

  def to_hash
    {
      car_reg_no: @car_reg_no,
      slot_no: @slot_no,
      entry_time: @entry_time,
      exit_time: @exit_time,
      duration: @duration,
      amount: @amount
    }
  end

  def self.init_file
    self.write_data([])
  end
end

