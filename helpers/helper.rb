require_relative '../utils/exceptions'

module Helper
  def park_car(car)
    empty_slot = Slot.empty_slot

    car.park(empty_slot.slot_no)
    empty_slot.park

    car
  end

  def unpark_car(car)
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

    invoice
  end

  def self.init_db
    Slot.init_file
    Car.init_file
    Invoice.init_file
  end

  def self.safe_file
    Slot.safe_file
    Car.safe_file
    Invoice.safe_file
  end

  def write_to_files
    Slot.write_data
    Car.write_data
    Invoice.write_data
  end
end
