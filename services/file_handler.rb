require "csv"
require "prawn"

module FileHandler
  DATA_DIR = "#{Dir.pwd}/data"
  INVOICES_DIR = "#{Dir.pwd}/invoices"

  def write_to_disk(data, path)
    Dir.mkdir(DATA_DIR) unless File.directory?(DATA_DIR)

    file = File.new(path, "w+")
    file.syswrite(data.to_json)
    file.close
  end

  def read_from_disk(path)
    arr = []
    file = File.new(path, "r")
    file.each do |line|
      arr = JSON.parse(line)
    end
    file.close
    arr
  end

  def write_invoice_to_txt(text, path)
    Dir.mkdir(INVOICES_DIR) unless File.directory?(INVOICES_DIR)
    File.write(path, text)
  end

  def write_invoice_to_csv(rows, path)
    Dir.mkdir(INVOICES_DIR) unless File.directory?(INVOICES_DIR)
    File.write(path, rows.map(&:to_csv).join)
  end

  def write_invoice_to_pdf(data, path)
    Dir.mkdir(INVOICES_DIR) unless File.directory?(INVOICES_DIR)
    Prawn::Document.generate(path) do
      text data
    end
  end

  def file_exist?(path)
    File.exist?(path)
  end
end