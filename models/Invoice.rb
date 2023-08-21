require_relative '../helpers/model_helper'

class Invoice
  extend ModelHelper

  @@filename = "invoices.json"
  attr_accessor :car_reg_no, :slot_no, :entry_time, :exit_time, :duration, :amount

  def initialize(car_reg_no: , slot_no: , entry_time: , exit_time: , duration: nil, amount: nil)
    @car_reg_no = car_reg_no
    @slot_no = slot_no
    @entry_time = entry_time
    @exit_time = exit_time
    @duration = Integer(exit_time - entry_time)
    @amount = calc_amount
  end
  
  def calc_amount
    case @duration
    when ..10
      100
    when 11..30
      200
    when 31..60
      300
    else
      500
    end
  end

  def print
    puts <<-END
------------------------------------------------
Your Invoice
      Car Registration Number: #{@car_reg_no}
      Duration: #{ @duration < 60 ? @duration.to_s + " seconds" : (@duration/60.0).round(2).to_s + " minutes" }
      Entry: #{@entry_time}
      Exit: #{@exit_time}
      Amount: #{@amount}
------------------------------------------------
    END
  end

  def self.create_object_from_hash(data)
    Invoice.new(car_reg_no: data["car_reg_no"], slot_no: Integer(data["slot_no"]), entry_time: Time.new(data["entry_time"]), exit_time: Time.new(data["exit_time"]), duration: Integer(data["duration"]), amount: Integer(data["amount"]))
  end

  def create_hash
    { car_reg_no: @car_reg_no, slot_no: @slot_no, entry_time: @entry_time, exit_time: @exit_time, duration: @duration, amount: @amount }
  end

  def self.init_file
    self.write_data_to_file([])
  end

end