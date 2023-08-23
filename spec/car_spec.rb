require_relative './spec_helper'

RSpec.describe Car do
  context "Registration number" do
    it "is valid" do
      expect(Car.is_valid?("AB12345678")).to be_truthy
    end

    context "is invalid if" do
      it "does not begin with 2 alphabets" do
        expect{Car.is_valid?("12ASDF34")}.to raise_error(InvalidRegNo)
      end

      it "does not have 8 digits at end" do
        expect{Car.is_valid?("AB1234ASDF")}.to raise_error(InvalidRegNo)
      end

      it "has length less than 10" do
        expect{Car.is_valid?("AB1234")}.to raise_error(InvalidRegNo)
      end

      it "has length greater than 10" do
        expect{Car.is_valid?("AB123456789")}.to raise_error(InvalidRegNo)
      end

      it "has a special character " do
        expect{Car.is_valid?("AB123$5678")}.to raise_error(InvalidRegNo)
      end

      it "has a whitespace " do
        expect{Car.is_valid?("AB 123 5678")}.to raise_error(InvalidRegNo)
      end
    end
  end
end