require_relative './spec_helper'

describe "#from database" do
  context "car" do
    it "reads data" do
      expect(Car).to receive(:read_from_disk).with("cars.json")
      expect(Car.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Car).to receive(:write_to_disk).with([], "cars.json")
      Car.write_data([])
    end

    it "writes dummy data" do
      dummy_cars = [Car.new(reg_no: "AB00000000"), Car.new(reg_no: "AB99999999")]
      dummy_hash = dummy_cars.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "cars.json")
      Car.write_data(dummy_cars)
    end
  end

  context "invoice" do
    it "reads data" do
      expect(Invoice).to receive(:read_from_disk).with("invoices.json")
      expect(Invoice.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Invoice).to receive(:write_to_disk).with([], "invoices.json")
      Invoice.write_data([])
    end

    it "writes dummy data" do
      dummy_invoices = [
        Invoice.new(
          car_reg_no: "AB12345678",
          slot_no: 3,
          entry_time: Time.now.round - 35,
          exit_time: Time.now.round
        ),
        Invoice.new(
          car_reg_no: "AB12345679",
          slot_no: 5,
          entry_time: Time.now.round - 120,
          exit_time: Time.now.round
        )
      ]
      dummy_hash = dummy_invoices.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "cars.json")
      Car.write_data(dummy_invoices)
    end
  end

  context "slot" do
    it "reads data" do
      expect(Slot).to receive(:read_from_disk).with("slots.json")
      expect(Slot.read_data).to be_instance_of(Array)
    end

    it "writes empty data" do
      expect(Slot).to receive(:write_to_disk).with([], "slots.json")
      Slot.write_data([])
    end

    it "writes dummy data" do
      dummy_slots = [Slot.new(slot_no: 2), Slot.new(slot_no: 4)]
      dummy_hash = dummy_slots.map(&:to_hash)

      expect(Car).to receive(:write_to_disk).with(dummy_hash, "cars.json")
      Car.write_data(dummy_slots)
    end
  end
end