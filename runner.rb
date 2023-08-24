require 'optparse'
require_relative './controllers/parking_lot_controller'
require_relative './utils/exceptions'

class Runner
  def initialize
    @parser = get_opt_parser
    @parser.parse!

  rescue InvalidRegNo => e
    puts "Error: #{e}"

  rescue InvalidPhoneNo => e
    puts "Error: #{e}"

  rescue CarAlreadyParked => e
    puts "Error: #{e}"

  rescue InvalidSlotId => e
    puts "Error: #{e}"

  rescue NoSlotAvailable => e
    puts "Error: #{e}"

  rescue CarNotFound => e
    puts "Error: #{e}"

  rescue InvoiceNotFound => e
    puts "Error: #{e}"

  rescue SlotActive => e
    puts "Error: #{e}"

  rescue StandardError => e
    puts "Error: #{e}"
  end
end

def get_opt_parser
  parking_lot = ParkingLot.new
  OptionParser.new do |opts|

    opts.on("-r", "--reset", "Reset parking lot data") do
      ParkingLot.init_db
    end

    opts.on("--park-reg REG_NO", "Park your car using registration number") do |reg_no|
      parking_lot.park_reg_no(reg_no.upcase)
    end

    opts.on("--park-phone PHONE", "Park your car using phone number") do |phone|
      parking_lot.park_phone_no(phone)
    end

    opts.on("--unpark-reg REG_NO", "Unpark your car using registration number") do |reg_no|
      parking_lot.unpark_reg_no(reg_no.upcase)
    end

    opts.on("--unpark-phone PHONE", "Unpark your car using phone number") do |phone|
      parking_lot.unpark_phone_no(phone)
    end

    opts.on("--list-cars", "List all parked cars") do
      parking_lot.list_cars
    end

    opts.on("--list-invoices", "List all invoices") do
      parking_lot.print_all_invoices
    end

    opts.on("--list-invoice INVOICE_ID", Integer, "Show a particular invoice") do |invoice_id|
      parking_lot.print_invoice_by_id(invoice_id)
    end

    opts.on("--print-csv INVOICE_ID", Integer, "Print invoice to csv file") do |invoice_id|
      parking_lot.print_invoice_to_file(invoice_id, "csv")
    end

    opts.on("--print-txt INVOICE_ID", Integer, "Print invoice to txt file") do |invoice_id|
      parking_lot.print_invoice_to_file(invoice_id, "txt")
    end

    opts.on("--print-pdf INVOICE_ID", Integer, "Print invoice to pdf file") do |invoice_id|
      parking_lot.print_invoice_to_file(invoice_id, "pdf")
    end

    opts.on("--deactivate-slot SLOT_NO", Integer, "Mark a slot as inactive") do |slot_no|
      parking_lot.deactivate_slot(slot_no)
    end

    opts.on("--activate-slot SLOT_NO", Integer, "Mark a slot as active") do |slot_no|
      parking_lot.activate_slot(slot_no)
    end

    opts.on("--add-slots INCREMENT", Integer, "Add slots") do |increment|
      parking_lot.increase_slots(increment)
    end
  end
end

Runner.new
