require_relative '../models/Invoice'
require_relative '../models/ParkingLot'

RSpec.describe Invoice do
  let(:invoice) { Invoice.new(car_reg_no: "AB12345678", slot_no: 3, entry_time: Time.now - 35, exit_time: Time.now) }

  it "should create an invoice object" do
    expect(invoice).to be_instance_of(Invoice)
  end

  it "should calculate accurate amount" do
    expect(invoice.calc_amount).to be(300)
  end

  it "should print all invoices" do
    expect(ParkingLot.new.print_all_invoices).to be_instance_of(Array)
  end
end