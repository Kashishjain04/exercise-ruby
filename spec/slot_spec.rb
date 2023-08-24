require_relative './spec_helper'

describe Slot do
  it "should deactivate an active slot" do
    parking_lot = ParkingLot.new
    parking_lot.deactivate_slot(1)
    expect(Slot.empty_slot.slot_no).to be(2)
  end

  it "should activate an inactive slot" do
    parking_lot = ParkingLot.new
    parking_lot.deactivate_slot(1)
    parking_lot.activate_slot(1)
    expect(Slot.empty_slot.slot_no).to be(1)
  end

  it "should find a slot by slot_no" do
    ParkingLot.new
    expect(Slot.find(2)).to be_instance_of(Slot)
  end

  it "should convert a slot instance to hash and vice-versa" do
    slot = Slot.new(slot_no: 1)
    hash = slot.to_hash
    expect(Slot.initialize_from_hash(hash))
      .to have_attributes(
            slot_no: slot.slot_no,
            occupied: slot.occupied,
            active: slot.active
          )
  end

  it "should increase slots in the parking lot" do
    initial_slots = Slot.class_variable_get(:@@collection).length
    Slot.increase_slots(4)
    expect(Slot.class_variable_get(:@@collection).length).to be(initial_slots + 4)
  end

  it "should not deactivate an already inactive slot" do
    parking_lot = ParkingLot.new
    parking_lot.deactivate_slot(1)
    expect { parking_lot.deactivate_slot(1) }.to raise_error(SlotActive)
  end

  it "should not activate an already active slot" do
    parking_lot = ParkingLot.new
    expect { parking_lot.activate_slot(1) }.to raise_error(SlotActive)
  end
end