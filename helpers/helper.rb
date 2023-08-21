require_relative '../utils/exceptions'

module Helper
  DIRNAME = "#{Dir.pwd}/data"

  def self.init_db
    Dir.mkdir(DIRNAME) unless File.directory?(DIRNAME)

    Slot.init_file
    Car.init_file
    Invoice.init_file
  end

  def self.safe_file
    Slot.safe_file
    Car.safe_file
    Invoice.safe_file
  end

  def write_to_files(slots, cars, invoices)
    Slot.write_data_to_file(slots)
    Car.write_data_to_file(cars)
    Invoice.write_data_to_file(invoices)
    true
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
