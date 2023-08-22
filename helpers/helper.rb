require_relative '../utils/exceptions'

module Helper
  DIRNAME = "#{Dir.pwd}/data"

  def self.init_db
    Dir.mkdir(DIRNAME) unless File.directory?(DIRNAME)

    Slot.init_file
    Car.init_file
    Invoice.init_file
  end

  def self.safe_file
    Dir.mkdir(DIRNAME) unless File.directory?(DIRNAME)

    Slot.safe_file
    Car.safe_file
    Invoice.safe_file
  end

  def write_to_files
    Slot.write_data_to_file
    Car.write_data_to_file
    Invoice.write_data_to_file
    true
  end

end
