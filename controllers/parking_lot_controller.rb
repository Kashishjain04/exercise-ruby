require "json"
require_relative "../models/slot"
require_relative "../models/car"
require_relative "../models/invoice"
require_relative "../helpers/helper"
require_relative "../utils/exceptions"
require_relative "../views/car_view"
require_relative "../views/invoice_view"
require_relative "../views/slot_view"
require_relative "../views/parking_lot_view"

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

  def park(id)
    new_car = Car.new(id: id)
    empty_slot = Slot.empty_slot

    new_car.park(empty_slot.slot_no)
    empty_slot.park(id)

    ParkingLotView.park(empty_slot.slot_no)
    true
  end

  def unpark(id)
    car = Car.find(id)
    slot = Slot.find(car.slot_no)

    invoice = Invoice.new(
      car_reg_no: car.reg_no,
      car_phone_no: car.phone,
      slot_no: slot.slot_no,
      entry_time: car.entry_time,
      exit_time: Time.now.round
    )

    slot.unpark
    car.unpark

    ParkingLotView.unpark(car.slot_no, invoice.invoice_id)
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

  def print_invoice_to_file(invoice_id, format)
    path = Invoice.find(invoice_id).print_to_file(format)
    InvoiceView.saved_to(path)
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

  def increase_slots(increment)
    Slot.increase_slots(increment)
    SlotView.added(increment)
  end
end
