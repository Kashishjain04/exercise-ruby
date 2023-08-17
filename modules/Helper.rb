require_relative '../utils/exceptions'

module Helper
  def self.init_db
    slots = []
    (1..10).each do |i|
      slots << {slot_no: i, occupied: false}
    end
    slots_file = File.new("data/slots.json", "w+")
    slots_file.syswrite(slots.to_json)
    slots_file.close

    cars_file = File.new("data/cars.json", "w+")
    cars_file.syswrite([])
    cars_file.close

    invoices_file = File.new("data/invoices.json", "w+")
    invoices_file.syswrite([])
    invoices_file.close
  end

  def read_slots_from_file
    slots = []
    slots_file = File.new("data/slots.json", "r")
    slots_file.each do |line|
      array = JSON.parse(line)
      array.each do | slot |
        slots << Slot.new(slot_no: slot["slot_no"], occupied: slot["occupied"])
      end
    end
    slots_file.close

    slots
  end

  def read_cars_from_file
    cars = []

    cars_file = File.new("data/cars.json", "r")
    cars_file.each do |line|
      array = JSON.parse(line)
      array.each do |car|
        cars << Car.new(reg_no: car["reg_no"], slot_no: car["slot_no"], entry_time: car["entry_time"])
      end
    end
    cars_file.close

    cars
  end

  def read_invoices_from_file
    invoices = []

    invoices_file = File.new("data/invoices.json", "r")
    invoices_file.each do |line|
      array = JSON.parse(line)
      array.each do |invoice|
        invoices << Invoice.new(car_reg_no: invoice["car_reg_no"], slot_no: invoice["slot_no"], entry_time: invoice["entry_time"], exit_time: invoice["exit_time"], duration: invoice["duration"], amount: invoice["amount"])
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

end
