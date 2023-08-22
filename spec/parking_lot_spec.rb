require_relative '../models/parking_lot'

RSpec.describe ParkingLot do
  before(:all) do
    @parking_lot = ParkingLot.new
  end

  it "should generate an instance of parking lot" do
    expect(@parking_lot).to be_instance_of(ParkingLot)
  end

  it "should park a valid car" do
    parked = @parking_lot.park("AB12345678")
    # returns slot_id after parking
    expect(parked).to be_instance_of(Integer)
  end

  it "should unpark a car" do
    unparked = @parking_lot.unpark("AB12345678")
    # returns invoice_id
    expect(unparked).to be_instance_of(Integer)
  end

  it "should write all data to files" do
    expect(@parking_lot.write_to_files).to be true
  end
end