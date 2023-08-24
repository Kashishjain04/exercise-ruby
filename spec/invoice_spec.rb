require 'spec_helper'

RSpec.describe Invoice do
  let(:invoice) {
    Invoice.new(
      car_reg_no: "AB12345678",
      car_phone_no: nil,
      slot_no: 3,
      entry_time: Time.now.round - 35,
      exit_time: Time.now.round
    )
  }

  context "if invoice data is valid" do
    it "convert an invoice instance to hash and vice-versa" do
      hash = invoice.to_hash
      expect(Invoice.initialize_from_hash(hash))
        .to have_attributes(
              invoice_id: invoice.invoice_id,
              car_reg_no: invoice.car_reg_no,
              slot_no: invoice.slot_no,
              entry_time: invoice.entry_time,
              exit_time: invoice.exit_time
            )
    end

    it "should find an existing invoice" do
      id = invoice.invoice_id
      expect(Invoice.find(id)).to be_instance_of(Invoice)
    end

    it "should print to csv file" do
      expect(File).to receive(:write)
      expect(invoice.print_to_file("csv"))
        .to eq("#{Invoice::INVOICES_DIR}/invoice-##{invoice.invoice_id}.csv")
    end

    it "should print to txt file" do
      expect(File).to receive(:write)
      expect(invoice.print_to_file("txt"))
        .to eq("#{Invoice::INVOICES_DIR}/invoice-##{invoice.invoice_id}.txt")
    end

    it "should print to pdf file" do
      expect(Prawn::Document).to receive(:generate)
      expect(invoice.print_to_file("pdf"))
        .to eq("#{Invoice::INVOICES_DIR}/invoice-##{invoice.invoice_id}.pdf")
    end
  end

  context "if invoice data is invalid" do
    it "should raise error" do
      expect{Invoice.new(
        car_reg_no: nil,
        car_phone_no: nil,
        slot_no: 3,
        entry_time: Time.now.round - 35,
        exit_time: Time.now.round
      )}.to raise_error(ArgumentError)
    end
  end

  it "should not look of a non existent invoice" do
    ParkingLot.new
    expect { Invoice.find(1) }.to raise_error(InvoiceNotFound)
  end
end