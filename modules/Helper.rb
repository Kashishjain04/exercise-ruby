require_relative '../utils/exceptions'

module Helper
  DIRNAME = "#{Dir.pwd}/data"
  MAX_SLOTS = 10
  FILE_NAMES = {slot: "slots.json", car: "cars.json", invoice: "invoices.json"}

  def self.init_db
    Dir.mkdir(DIRNAME) unless File.directory?(DIRNAME)

    temp_slots = []
    (1..MAX_SLOTS).each do |i|
      temp_slots << { slot_no: i, occupied: false }
    end
    slots_file = File.new("#{DIRNAME}/#{FILE_NAMES[:slot]}", "w+")
    slots_file.syswrite(temp_slots.to_json)
    slots_file.close

    cars_file = File.new("#{DIRNAME}/#{FILE_NAMES[:car]}", "w+")
    cars_file.syswrite([])
    cars_file.close

    invoices_file = File.new("#{DIRNAME}/#{FILE_NAMES[:invoice]}", "w+")
    invoices_file.syswrite([])
    invoices_file.close
  end

  def read_slots_from_file
    slots = []
    slots_file = File.new("#{DIRNAME}/#{FILE_NAMES[:slot]}", "r")
    slots_file.each do |line|
      array = JSON.parse(line)
      array.each do | slot |
        slots << Slot.new(slot_no: Integer(slot["slot_no"]), occupied: slot["occupied"])
      end
    end
    slots_file.close

    slots
  end

  def read_cars_from_file
    cars = []

    cars_file = File.new("#{DIRNAME}/#{FILE_NAMES[:car]}", "r")
    cars_file.each do |line|
      array = JSON.parse(line)
      array.each do |car|
        cars << Car.new(reg_no: car["reg_no"], slot_no: Integer(car["slot_no"]), entry_time: Time.new(car["entry_time"]))
      end
    end
    cars_file.close

    cars
  end

  def read_invoices_from_file
    invoices = []

    invoices_file = File.new("#{DIRNAME}/#{FILE_NAMES[:invoice]}", "r")
    invoices_file.each do |line|
      array = JSON.parse(line)
      array.each do |invoice|
        invoices << Invoice.new(car_reg_no: invoice["car_reg_no"], slot_no: Integer(invoice["slot_no"]), entry_time: Time.new(invoice["entry_time"]), exit_time: Time.new(invoice["exit_time"]), duration: Integer(invoice["duration"]), amount: Integer(invoice["amount"]))
      end
    end
    invoices_file.close

    invoices
  end

  def find_invoice_by_reg_no(invoices, reg_no)
    invoices.index{ |item| item.car_reg_no == reg_no }
  end

  def find_car(cars, reg_no)
    cars.index{ |item| item.reg_no == reg_no }
  end

  def find_empty_slot(slots)
    empty_slot = slots.find{ |slot| slot.occupied == false }

    raise NoSlotAvailable, "Empty slot not available" if empty_slot.nil?

    empty_slot
  end

  def write_to_files(slots, cars, invoices)
    write_slots_to_file(slots)
    write_cars_to_file(cars)
    write_invoices_to_file(invoices)

    true
  end

  def write_slots_to_file(slots = (1..10))
    temp_slots = []
    slots.each do |slot|
      temp_slots << { slot_no: slot.slot_no, occupied: slot.occupied }
    end
    slots_file = File.new("#{DIRNAME}/#{FILE_NAMES[:slot]}", "w+")
    slots_file.syswrite(temp_slots.to_json)
    slots_file.close
  end

  def write_cars_to_file(cars = [])
    temp_cars = []
    cars.each do |car|
      temp_cars << { reg_no: car.reg_no, slot_no: car.slot_no, entry_time: car.entry_time }
    end
    cars_file = File.new("#{DIRNAME}/cars.json", "w+")
    cars_file.syswrite(temp_cars.to_json)
    cars_file.close
  end

  def write_invoices_to_file(invoices = [])
    temp_invoices = []
    invoices.each do |invoice|
      temp_invoices << { car_reg_no: invoice.car_reg_no, slot_no: invoice.slot_no, entry_time: invoice.entry_time, exit_time: invoice.exit_time, duration: invoice.duration, amount: invoice.amount }
    end
    invoices_file = File.new("#{DIRNAME}/invoices.json", "w+")
    invoices_file.syswrite(temp_invoices.to_json)
    invoices_file.close
  end
end
