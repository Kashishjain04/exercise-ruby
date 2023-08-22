require_relative '../models/car'
require_relative '../models/parking_lot'
require_relative '../utils/exceptions'

RSpec.describe Car do
  context "Registration number" do
    it "is valid" do
      expect(Car.is_valid?("AB12345678")).to be true
    end

    context "is invalid if" do
      it "does not begin with 2 alphabets" do
        expect(Car.is_valid?("12ASDF34")).to be false
      end

      it "does not have 8 digits at end" do
        expect(Car.is_valid?("AB1234ASDF")).to be false
      end

      it "has length less than 10" do
        expect(Car.is_valid?("AB1234")).to be false
      end

      it "has length greater than 10" do
        expect(Car.is_valid?("AB123456789")).to be false
      end

      it "has a special character " do
        expect(Car.is_valid?("AB123$5678")).to be false
      end

      it "has a whitespace " do
        expect(Car.is_valid?("AB 123 5678")).to be false
      end
    end
  end

  it "should print list of parked cars" do
    parking_lot = ParkingLot.new
    ParkingLot.init_db
    parking_lot.park("AB12345678")

    expect(parking_lot.list_cars).to be_instance_of(Array)
  end
end