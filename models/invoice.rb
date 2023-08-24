require "time"
require_relative '../helpers/model_helper'
require_relative '../services/file_handler'

class Invoice
  extend ModelHelper
  include FileHandler

  PRICE_MAPPING = { ..10 => 100, 11..30 => 200, 31..60 => 300, 61.. => 500 }
  @@collection = []
  @@filename = "invoices.json"
  attr_accessor :car_reg_no, :car_phone_no, :slot_no, :entry_time, :exit_time, :duration, :amount, :invoice_id

  def initialize(
    car_reg_no:, car_phone_no:, slot_no:, entry_time:, exit_time:, duration: nil, amount: nil, invoice_id: nil
  )
    raise ArgumentError if car_reg_no.nil? and car_phone_no.nil?
    @car_reg_no = car_reg_no
    @car_phone_no = car_phone_no
    @slot_no = slot_no
    @entry_time = entry_time
    @exit_time = exit_time
    @duration = duration || Integer(exit_time - entry_time)
    @amount = amount || calc_amount
    @invoice_id = invoice_id || @@collection.length + 1

    @@collection << self

    @invoice_id
  end

  def self.find(invoice_id)
    invoice = @@collection.find { |invoice| invoice.invoice_id == invoice_id }
    raise InvoiceNotFound if invoice.nil?

    invoice
  end

  def self.initialize_from_hash(data)
    Invoice.new(
      car_reg_no: data["car_reg_no"],
      car_phone_no: data["car_phone_no"],
      slot_no: Integer(data["slot_no"]),
      entry_time: Time.parse(data["entry_time"]),
      exit_time: Time.parse(data["exit_time"]),
      duration: Integer(data["duration"]),
      amount: Integer(data["amount"]),
      invoice_id: Integer(data["invoice_id"])
    )
  end

  def to_hash
    {
      "car_reg_no" => @car_reg_no,
      "car_phone_no" => @car_phone_no,
      "slot_no" => @slot_no,
      "entry_time" => @entry_time.to_s,
      "exit_time" => @exit_time.to_s,
      "duration" => @duration,
      "amount" => @amount,
      "invoice_id" => @invoice_id
    }
  end

  def self.init_file
    self.write_data([])
  end

  def print_to_file(format)
    file_name = "invoice-##{invoice_id}.#{format}"
    path = "#{INVOICES_DIR}/#{file_name}"

    send("print_to_#{format}", path)
  end

  def text_content
    <<-END
------------------------------------------------
Your Invoice: ##{@invoice_id}
      Car Registration Number: #{@car_reg_no || "N/A"}
      Owner Phone Number: #{@car_phone_no || "N/A"}
      Duration: #{parse_duration}
      Entry: #{@entry_time}
      Exit: #{@exit_time}
      Amount: #{@amount}
------------------------------------------------
    END
  end

  private
  def calc_amount
    PRICE_MAPPING.each { |range, value| return value if range === @duration }
  end

  def parse_duration
    @duration < 60 ? duration_in_seconds : duration_in_minutes
  end

  def duration_in_seconds
    @duration.to_s + " seconds"
  end

  def duration_in_minutes
    (@duration / 60.0).round(2).to_s + " minutes"
  end

  def print_to_csv(path)
    rows = [
      ["Car Registration Number", "Owner Phone Number", "Duration", "Entry Time", "Exit Time", "Amount"],
      [@car_reg_no || "N/A", @car_phone_no || "N/A", parse_duration, @entry_time, @exit_time, @amount]
    ]
    write_invoice_to_csv(rows, path)
    path
  end

  def print_to_txt(path)
    write_invoice_to_txt(text_content, path)
    path
  end

  def print_to_pdf(path)
    write_invoice_to_pdf(text_content, path)
    path
  end
end

