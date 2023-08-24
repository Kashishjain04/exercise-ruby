require 'optparse'
require_relative './controllers//parking_lot_controller'
require_relative './utils/exceptions'

class Runner
  def initialize
    @parser = get_opt_parser
    @parser.parse!

  rescue InvalidRegNo => e
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
  end
end

def get_opt_parser
  OptionParser.new do |opts|

    opts.on("-r", "--reset", "Reset parking lot data") do
      ParkingLot.init_db
    end

    opts.on("-p reg_no", "--park", "Park your car") do |reg_no|
      parking_lot = ParkingLot.new
      parking_lot.park(reg_no.upcase)
      parking_lot.write_to_files
    end

    opts.on("-u reg_no", "--unpark", "Find and unpark your car") do |reg_no|
      parking_lot = ParkingLot.new
      parking_lot.unpark(reg_no.upcase)
      parking_lot.write_to_files
    end

    opts.on("-l", "--list", "List all parked cars") do
      parking_lot = ParkingLot.new
      parking_lot.list_cars
    end

    opts.on("-i [invoice_id]", "--invoice", "Print invoice/s") do |invoice_id|
      parking_lot = ParkingLot.new
      invoice_id.nil? ?
        parking_lot.print_all_invoices :
        parking_lot.print_invoice_by_id(Integer(invoice_id))
    end

    opts.on("-c invoice_id", "--csv", "Print invoice to csv file") do |invoice_id|
      parking_lot = ParkingLot.new
      parking_lot.print_invoice_to_file(Integer(invoice_id), "csv")
    end

    opts.on("-t invoice_id", "--txt", "Print invoice to text file") do |invoice_id|
      parking_lot = ParkingLot.new
      parking_lot.print_invoice_to_file(Integer(invoice_id), "txt")
    end

    opts.on("-p invoice_id", "--pdf", "Print invoice to pdf file") do |invoice_id|
      parking_lot = ParkingLot.new
      parking_lot.print_invoice_to_file(Integer(invoice_id), "pdf")
    end

    opts.on("-d slot_no", "--deactivate", "Mark a slot as inactive") do |slot_no|
      parking_lot = ParkingLot.new
      parking_lot.deactivate_slot(Integer(slot_no))
      parking_lot.write_to_files
    end

    opts.on("-a slot_no", "--activate", "Mark a slot as inactive") do |slot_no|
      parking_lot = ParkingLot.new
      parking_lot.activate_slot(Integer(slot_no))
      parking_lot.write_to_files
    end

    opts.on("-s increment", "Add slots") do |increment|
      parking_lot = ParkingLot.new
      parking_lot.increase_slots(Integer(increment))
      parking_lot.write_to_files
    end
  end
end

Runner.new