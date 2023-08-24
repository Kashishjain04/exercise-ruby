require_relative './spec_helper'

describe "#from database" do
  describe "car" do
    it "reads data" do
      expect(Car).to receive(:read_from_disk).with("#{FileHandler::DATA_DIR}/cars.json")
      expect(Car.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Car).to receive(:write_to_disk).with([], "#{FileHandler::DATA_DIR}/cars.json")
      Car.write_data([])
    end

    it "writes dummy data" do
      dummy_cars = [Car.new(reg_no: "AB00000000"), Car.new(phone: "9999999999")]
      dummy_hash = dummy_cars.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "#{FileHandler::DATA_DIR}/cars.json")
      Car.write_data(dummy_cars)
    end
  end

  describe "invoice" do
    it "reads data" do
      expect(Invoice).to receive(:read_from_disk).with("#{FileHandler::DATA_DIR}/invoices.json")
      expect(Invoice.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Invoice).to receive(:write_to_disk).with([], "#{FileHandler::DATA_DIR}/invoices.json")
      Invoice.write_data([])
    end

    it "writes dummy data" do
      dummy_invoices = [
        Invoice.new(
          car_reg_no: "AB12345678",
          car_phone_no: nil,
          slot_no: 3,
          entry_time: Time.now.round - 35,
          exit_time: Time.now.round
        ),
        Invoice.new(
          car_reg_no: nil,
          car_phone_no: "9999999999",
          slot_no: 5,
          entry_time: Time.now.round - 120,
          exit_time: Time.now.round
        )
      ]
      dummy_hash = dummy_invoices.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "#{FileHandler::DATA_DIR}/cars.json")
      Car.write_data(dummy_invoices)
    end
  end

  describe "slot" do
    it "reads data" do
      expect(Slot).to receive(:read_from_disk).with("#{FileHandler::DATA_DIR}/slots.json")
      expect(Slot.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Slot).to receive(:write_to_disk).with([], "#{FileHandler::DATA_DIR}/slots.json")
      Slot.write_data([])
    end

    it "writes dummy data" do
      dummy_slots = [Slot.new(slot_no: 2), Slot.new(slot_no: 4)]
      dummy_hash = dummy_slots.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "#{FileHandler::DATA_DIR}/cars.json")
      Car.write_data(dummy_slots)
    end
  end
end