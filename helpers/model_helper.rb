require "json"
require_relative './helper'
require_relative '../services/file_handler'

module ModelHelper
  include FileHandler
  def write_data(data = nil)
    data ||= self.class_variable_get(:@@collection)
    arr = data.map(&:to_hash)
    path = "#{DATA_DIR}/#{self.class_variable_get(:@@filename)}"
    write_to_disk(arr, path)
  end

  def read_data
    path = "#{DATA_DIR}/#{self.class_variable_get(:@@filename)}"
    data = read_from_disk(path)
    data.map { |item| self.initialize_from_hash(item) }
  end

  def safe_file
    exist = file_exist?("#{DATA_DIR}/#{self.class_variable_get(:@@filename)}")
    self.init_file unless exist
  end
end