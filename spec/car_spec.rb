require_relative './spec_helper'

RSpec.describe Car do
  describe "Registration number" do
    context "to be valid" do
      it "should have exactly 2 alphabets followed by exactly 8 digits" do
        expect(Car.is_valid_reg?("AB12345678")).to be_truthy
      end
    end

    context "to be invalid" do
      it "should not begin with 2 alphabets" do
        expect { Car.is_valid_reg?("12ASDF34") }.to raise_error(InvalidRegNo)
      end

      it "should not have 8 digits at end" do
        expect { Car.is_valid_reg?("AB1234ASDF") }.to raise_error(InvalidRegNo)
      end

      it "should be of length less than 10" do
        expect { Car.is_valid_reg?("AB1234") }.to raise_error(InvalidRegNo)
      end

      it "should be of length greater than 10" do
        expect { Car.is_valid_reg?("AB123456789") }.to raise_error(InvalidRegNo)
      end

      it "should have special characters " do
        expect { Car.is_valid_reg?("AB123$5678") }.to raise_error(InvalidRegNo)
      end

      it "should have whitespaces " do
        expect { Car.is_valid_reg?("AB 123 5678") }.to raise_error(InvalidRegNo)
      end
    end
  end

  describe "Phone number" do
    context "to be valid" do
      it "should have exactly 10 digits" do
        expect(Car.is_valid_phone?("9876543210")).to be_truthy
      end
    end

    context "to be invalid" do
      it "should have alphabets" do
        expect{Car.is_valid_phone?("9876543A10")}.to raise_error(InvalidPhoneNo)
      end

      it "should have whitespace" do
        expect{Car.is_valid_phone?("9876543 10")}.to raise_error(InvalidPhoneNo)
      end

      it "should have special characters" do
        expect{Car.is_valid_phone?("9876543@10")}.to raise_error(InvalidPhoneNo)
      end

      it "should be of length less than 10" do
        expect{Car.is_valid_phone?("987654310")}.to raise_error(InvalidPhoneNo)
      end

      it "should be of length greater than 10" do
        expect{Car.is_valid_phone?("98765431011")}.to raise_error(InvalidPhoneNo)
      end
    end
  end

  it "finds a parked car by registration number" do
    parking_lot = ParkingLot.new
    parking_lot.park_reg_no("AB12345678")
    expect(Car.find(reg_no: "AB12345678")).to be_instance_of(Car)
    parking_lot.unpark_reg_no("AB12345678")
  end

  it "finds a parked car by phone number" do
    parking_lot = ParkingLot.new
    parking_lot.park_phone_no("9876543210")
    expect(Car.find(phone: "9876543210")).to be_instance_of(Car)
    parking_lot.unpark_phone_no("9876543210")
  end

  it "does not find a non existent car" do
    expect{Car.find(reg_no: "AB12345678")}.to raise_error(CarNotFound)
  end

  it "converts a car instance to hash and vice-versa" do
    car = Car.new(reg_no: "AB12345678")
    hash = car.to_hash
    expect(Car.initialize_from_hash(hash))
      .to have_attributes(
            reg_no: car.reg_no,
            phone: nil,
            slot_no: car.slot_no,
            entry_time: car.entry_time
          )
  end
end