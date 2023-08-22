require "json"
require_relative './slot'
require_relative './car'
require_relative './invoice'
require_relative '../helpers/helper'
require_relative '../utils/exceptions'

class ParkingLot
  include Helper

  def initialize
    Helper::safe_file

    Car.read_data_from_file
    Slot.read_data_from_file
    Invoice.read_data_from_file
  # rescue Errno::ENOENT => e
  #   $stderr.puts "Caught the exception: #{e}"
  #   exit -1
  end

  def self.init_db
    Helper.init_db
  end

  def park(reg_no)
    new_car = Car.new(reg_no: reg_no)
    empty_slot = Slot.empty_slot

    new_car.park(empty_slot.slot_no)
    empty_slot.park(new_car)

    puts "Park your car at slot number: #{empty_slot.slot_no}"
    empty_slot.slot_no
  end

  def unpark(reg_no)
    car = Car.find(reg_no)
    slot = Slot.find(&:slot_no)

    puts "Take your car from slot number: #{car.slot_no}"

    invoice = Invoice.new(car_reg_no: reg_no, slot_no: car.slot_no, entry_time: car.entry_time, exit_time: Time.now)

    slot.unpark
    car.unpark

    puts "Your invoice is generated with invoice_id: #{invoice.invoice_id}"

    invoice.print
    invoice.invoice_id
  end

  def list_cars
    Car.list
  end

  def print_all_invoices
    Invoice.list
  end

  def print_invoice_by_id(invoice_id)
    Invoice.find(invoice_id).print
  end

end