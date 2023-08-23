require_relative './spec_helper'

describe "#from database" do
  context "car" do
    it "reads data" do
      expect(Car).to receive(:read_from_disk).with("cars.json")
      expect(Car.read_data).to be_instance_of(Array)
    end

    it "writes data" do
      expect(Car).to receive(:write_to_disk).with([], "cars.json")
      Car.write_data([])
    end
  end

  context "invoice" do
    it "reads data" do
      expect(Invoice).to receive(:read_from_disk).with("invoices.json")
      expect(Invoice.read_data).to be_instance_of(Array)
    end

    it "writes data" do
      expect(Invoice).to receive(:write_to_disk).with([], "invoices.json")
      Invoice.write_data([])
    end
  end

  context "slot" do
    it "reads data" do
      expect(Slot).to receive(:read_from_disk).with("slots.json")
      expect(Slot.read_data).to be_instance_of(Array)
    end

    it "writes data" do
      expect(Slot).to receive(:write_to_disk).with([], "slots.json")
      Slot.write_data([])
    end
  end
end