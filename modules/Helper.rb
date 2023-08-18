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
    self.init_file(:slot, temp_slots.to_json)

    self.init_file(:car, [])
    self.init_file(:invoice, [])
  end

  def self.init_file(type, data)
    Dir.mkdir(DIRNAME) unless File.directory?(DIRNAME)
    file = File.new("#{DIRNAME}/#{FILE_NAMES[type]}", "w+")
    file.syswrite(data)
    file.close
  end

  def self.safe_file
    exist = File.exist?("#{DIRNAME}/#{FILE_NAMES[:slot]}")
    unless exist
      temp_slots = []
      (1..MAX_SLOTS).each do |i|
        temp_slots << { slot_no: i, occupied: false }
      end

      self.init_file(:slot, temp_slots.to_json)
    end

    exist = File.exist?("#{DIRNAME}/#{FILE_NAMES[:car]}")
    self.init_file(:car, []) unless exist

    exist = File.exist?("#{DIRNAME}/#{FILE_NAMES[:invoice]}")
    self.init_file(:invoice, []) unless exist
  end

  def read_item_from_file(type)
    arr = []
    file = File.new("#{DIRNAME}/#{FILE_NAMES[type]}", "r")
    file.each do |line|
      data = JSON.parse(line)
      data.each do |item|
        arr << case type
        when :slot
          create_slot_object(item)
        when :car
          create_car_object(item)
        when :invoice
          create_invoice_object(item)
        end
      end
    end
    file.close

    arr
  end

  def create_slot_object(details)
    Slot.new(slot_no: Integer(details["slot_no"]), occupied: details["occupied"])
  end

  def create_car_object(details)
    Car.new(reg_no: details["reg_no"], slot_no: Integer(details["slot_no"]), entry_time: Time.new(details["entry_time"]))
  end

  def create_invoice_object(details)
    Invoice.new(car_reg_no: details["car_reg_no"], slot_no: Integer(details["slot_no"]), entry_time: Time.new(details["entry_time"]), exit_time: Time.new(details["exit_time"]), duration: Integer(details["duration"]), amount: Integer(details["amount"]))
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
    write_item_to_file(:slot, slots)
    write_item_to_file(:car, cars)
    write_item_to_file(:invoice, invoices)
    true
  end

  def write_item_to_file(type, data)
    arr = []
    data.each do |item|
      arr << case type
        when :slot
          create_slot_hash(item)
        when :car
          create_car_hash(item)
        when :invoice
          create_invoice_hash(item)
      end
    end

    file = File.new("#{DIRNAME}/#{FILE_NAMES[type]}", "w+")
    file.syswrite(arr.to_json)
    file.close
  end

  def create_slot_hash(slot)
    {slot_no: slot.slot_no, occupied: slot.occupied}
  end

  def create_car_hash(car)
    { reg_no: car.reg_no, slot_no: car.slot_no, entry_time: car.entry_time }
  end

  def create_invoice_hash(invoice)
    { car_reg_no: invoice.car_reg_no, slot_no: invoice.slot_no, entry_time: invoice.entry_time, exit_time: invoice.exit_time, duration: invoice.duration, amount: invoice.amount }
  end
end
