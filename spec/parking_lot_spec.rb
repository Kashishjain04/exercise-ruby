require_relative './spec_helper'

RSpec.describe ParkingLot do
  it "should park a valid car with registration number" do
    parking_lot = ParkingLot.new
    parked = parking_lot.park_reg_no("AB12345678")
    expect(parked).to be_truthy
    parking_lot.unpark_reg_no("AB12345678")
  end

  it "should park a valid car with phone number" do
    parking_lot = ParkingLot.new
    parked = parking_lot.park_phone_no("9876543210")
    expect(parked).to be_truthy
    parking_lot.unpark_phone_no("9876543210")
  end

  it "should unpark already parked car" do
    parking_lot = ParkingLot.new
    parking_lot.park_reg_no("AB12345678")
    unparked = parking_lot.unpark_reg_no("AB12345678")

    expect(unparked).to be_truthy
  end

  it "should not accept already parked car" do
    parking_lot = ParkingLot.new
    parking_lot.park_reg_no("AB12345678")
    expect { parking_lot.park_reg_no("AB12345678") }.to raise_error(CarAlreadyParked)
    parking_lot.unpark_reg_no("AB12345678")
  end

  it "should not unpark non existing car" do
    parking_lot = ParkingLot.new
    expect { parking_lot.unpark_reg_no("AB12345678") }.to raise_error(CarNotFound)
  end
end