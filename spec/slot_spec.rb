require_relative './spec_helper'

describe Slot do
  context "does" do
    it "deactivate an active slot" do
      parking_lot = ParkingLot.new
      parking_lot.deactivate_slot(1)
      expect(Slot.empty_slot.slot_no).to be(2)
    end

    it "activates an inactive slot" do
      parking_lot = ParkingLot.new
      parking_lot.deactivate_slot(1)
      parking_lot.activate_slot(1)
      expect(Slot.empty_slot.slot_no).to be(1)
    end
  end
  context "does not" do
    it "deactivate an already inactive slot" do
      parking_lot = ParkingLot.new
      parking_lot.deactivate_slot(1)
      expect{parking_lot.deactivate_slot(1)}.to raise_error(SlotActive)
    end

    it "activate an already active slot" do
      parking_lot = ParkingLot.new
      expect{parking_lot.activate_slot(1)}.to raise_error(SlotActive)
    end
  end
end