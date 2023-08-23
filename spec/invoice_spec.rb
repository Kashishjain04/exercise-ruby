require_relative './spec_helper'

RSpec.describe Invoice do
  let!(:invoice) {
    Invoice.new(
      car_reg_no: "AB12345678",
      car_phone_no: nil,
      slot_no: 3,
      entry_time: Time.now.round - 35,
      exit_time: Time.now.round
    )
  }

  context "should" do
    it "calculate correct amount" do
      expect(invoice.calc_amount).to be(300)
    end

    it "find an existing invoice" do
      expect(Invoice.find(1)).to be_instance_of(Invoice)
    end

    it "converts an invoice instance to hash and vice-versa" do
      hash = invoice.to_hash
      expect(Invoice.initialize_from_hash(hash))
        .to have_attributes(
              car_reg_no: invoice.car_reg_no,
              slot_no: invoice.slot_no,
              entry_time: invoice.entry_time,
              exit_time: invoice.exit_time
            )
    end
  end

  context "should not" do
    it "find a non existent invoice" do
      expect { Invoice.find(10) }.to raise_error(InvoiceNotFound)
    end
  end
end