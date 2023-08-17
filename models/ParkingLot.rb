require "json"
require_relative './Slot'
require_relative './Car'
require_relative './Invoice'
require_relative '../modules/Helper'
require_relative '../utils/exceptions'

class ParkingLot
  include Helper

  def initialize
    @slots = read_slots_from_file
    @cars = read_cars_from_file
    @invoices = read_invoices_from_file
  end

  def park(reg_no)
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

    rescue InvalidRegNo => e
      puts "Error: #{e}"
  end

  def un_park(reg_no)
    # invoice_idx = find_invoice_by_reg_no(@invoices, reg_no)
    # raise CarNotFound if invoice_idx.nil?
    # details = @invoices[invoice_idx]

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
  end

  def list_cars
    @cars.each{ |item| item.print }
  end

  def print_all_invoices
    @invoices.each{ |item| item.print }
  end

  def print_invoice_by_id(invoice_id)
    raise InvoiceNotFound if invoice_id > @invoices.length

    @invoices[invoice_id-1].print
  end

end

# ParkingLot.init_db

parking_lot = ParkingLot.new
parking_lot.park("HR12345678")
parking_lot.park("HR12345679")
parking_lot.list_cars
parking_lot.un_park("HR12345678")
parking_lot.un_park("HR12345679")
parking_lot.print_all_invoices