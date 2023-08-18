require "json"
require_relative './slot'
require_relative './car'
require_relative './invoice'
require_relative '../modules/helper'
require_relative '../utils/exceptions'

class ParkingLot
  include Helper

  def initialize
    Helper::safe_file

    @slots = read_item_from_file(:slot)
    @cars = read_item_from_file(:car)
    @invoices = read_item_from_file(:invoice)

  rescue Errno::ENOENT => e
    $stderr.puts "Caught the exception: #{e}"
    exit -1
  end

  def park(reg_no)
    is_valid = Car.is_valid? reg_no
    raise InvalidRegNo, "Registration number: #{reg_no} is invalid." unless is_valid

    already = !(find_car(@cars, reg_no).nil?)
    if already
      puts "Car already parked"
      exit(1)
    end

    empty_slot = find_empty_slot(@slots)
    new_car = Car.new(reg_no: reg_no, slot_no: empty_slot.slot_no)

    @cars << new_car
    empty_slot.occupied = true

    puts "Park your car at slot number: #{empty_slot.slot_no}"
    empty_slot.slot_no
  end

  def un_park(reg_no)
    is_valid = Car.is_valid? reg_no
    raise InvalidRegNo, "Registration number: #{reg_no} is invalid." unless is_valid

    car_idx = find_car(@cars, reg_no)
    raise CarNotFound if car_idx.nil?
    car = @cars[car_idx]

    slot = @slots[car.slot_no - 1]

    puts "Take your car from slot number: #{car.slot_no}"

    invoice = Invoice.new(car_reg_no: reg_no, slot_no: car.slot_no, entry_time: car.entry_time, exit_time: Time.now)
    @invoices << invoice
    slot.occupied = false
    @cars.delete_at(car_idx)

    puts "Your invoice is generated with invoice_id: #{@invoices.length}"

    print_invoice_by_id(@invoices.length)
    @invoices.length
  end

  def list_cars
    @cars.each{ |item| item.print }
  end

  def print_all_invoices
    @invoices.each{ |item| item.print }
  end

  def print_invoice_by_id(invoice_id)
    raise InvoiceNotFound if invoice_id > @invoices.length or invoice_id <= 0

    @invoices[invoice_id-1].print
  end

  def write_to_files
    super(@slots, @cars, @invoices)
  end

end

def ParkingLot.init_db
  Helper.init_db
end