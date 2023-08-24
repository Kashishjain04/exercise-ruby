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

  def park_reg_no(reg_no)
    new_car = Car.new(reg_no: reg_no)
    car = park_car(new_car)

    ParkingLotView.park(car.slot_no)
    true
  end

  def park_phone_no(phone)
    new_car = Car.new(phone: phone)
    car = park_car(new_car)

    ParkingLotView.park(car.slot_no)
    true
  end

  def unpark_reg_no(reg_no)
    car = Car.find(reg_no: reg_no)
    invoice = unpark_car(car)

    ParkingLotView.unpark(invoice.slot_no, invoice.invoice_id)
    print_invoice_by_id(invoice.invoice_id)
    true
  end

  def unpark_phone_no(phone)
    car = Car.find(phone: phone)
    invoice = unpark_car(car)

    ParkingLotView.unpark(invoice.slot_no, invoice.invoice_id)
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
