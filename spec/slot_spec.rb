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

    it "find a slot by slot_no" do
      parking_lot = ParkingLot.new
      expect(Slot.find(2)).to be_instance_of(Slot)
    end

    it "converts a slot instance to hash and vice-versa" do
      slot = Slot.new(slot_no: 1)
      hash = slot.to_hash
      expect(Slot.initialize_from_hash(hash))
        .to have_attributes(
              slot_no: slot.slot_no,
              car_no: slot.car_no,
              active: slot.active
            )
    end

    it "increase slots in the parking lot" do
      initial_slots = Slot.class_variable_get(:@@collection).length
      Slot.increase_slots(4)
      expect(Slot.class_variable_get(:@@collection).length).to be(initial_slots + 4)
    end
  end

  context "does not" do
    it "deactivate an already inactive slot" do
      parking_lot = ParkingLot.new
      parking_lot.deactivate_slot(1)
      expect { parking_lot.deactivate_slot(1) }.to raise_error(SlotActive)
    end

    it "activate an already active slot" do
      parking_lot = ParkingLot.new
      expect { parking_lot.activate_slot(1) }.to raise_error(SlotActive)
    end
  end
end