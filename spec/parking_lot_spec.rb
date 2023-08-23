require_relative './spec_helper'

RSpec.describe ParkingLot do
  context "does" do
    it "park a valid car" do
      parked = ParkingLot.new.park("AB12345678")
      expect(parked).to be_truthy
    end

    it "unpark already parked car" do
      parking_lot = ParkingLot.new
      parking_lot.park("AB12345678")
      unparked = parking_lot.unpark("AB12345678")

      expect(unparked).to be_truthy
    end
  end
  context "does not" do
    it "accept already parked car" do
      parking_lot = ParkingLot.new
      parking_lot.park("AB12345678")
      expect { parking_lot.park("AB12345678") }.to raise_error(CarAlreadyParked)
    end

    it "unpark non existing car" do
      parking_lot = ParkingLot.new
      expect { parking_lot.unpark("AB12345678") }.to raise_error(CarNotFound)
    end
  end

end