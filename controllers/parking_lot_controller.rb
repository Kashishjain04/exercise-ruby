require "json"
require_relative "../models/slot"
require_relative "../models/car"
require_relative "../models/invoice"
require_relative "../helpers/helper"
require_relative "../utils/exceptions"
require_relative "../views/car_view"
require_relative "../views/invoice_view"
require_relative "../views/slot_view"

class ParkingLot
  include Helper

  def initialize
    Helper::safe_file

    Car.class_variable_set(:@@collection, Car.read_data)
    Slot.class_variable_set(:@@collection, Slot.read_data)
    Invoice.class_variable_set(:@@collection, Invoice.read_data)
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
    true
  end

  def unpark(reg_no)
    car = Car.find(reg_no)
    slot = Slot.find(car.slot_no)

    puts "Take your car from slot number: #{car.slot_no}"

    invoice = Invoice.new(
      car_reg_no: reg_no,
      slot_no: slot.slot_no,
      entry_time: car.entry_time,
      exit_time: Time.now.round
    )

    slot.unpark
    car.unpark

    puts "Your invoice is generated with invoice_id: #{invoice.invoice_id}"

    print_invoice_by_id(invoice.invoice_id)
    true
  end

  def list_cars
    CarView.list(Car.class_variable_get(:@@collection))
  end

  def print_all_invoices
    InvoiceView.list(Invoice.class_variable_get(:@@collection))
  end

  def print_invoice_by_id(invoice_id)
    InvoiceView.print(Invoice.find(invoice_id))
  end

  def deactivate_slot(slot_no)
    slot = Slot.find(slot_no)
    slot.mark_inactive
    SlotView.active(false)
  end

  def activate_slot(slot_no)
    slot = Slot.find(slot_no)
    slot.mark_active
    SlotView.active(true)
  end
end
