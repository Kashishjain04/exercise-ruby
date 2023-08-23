require "json"
require_relative './helper'

module ModelHelper
  def write_data(data = nil)
    data ||= self.class_variable_get(:@@collection)
    arr = data.map(&:to_hash)
    write_to_disk(arr, self.class_variable_get(:@@filename))
  end

  def read_data
    data = read_from_disk(self.class_variable_get(:@@filename))
    data.map { |item| self.initialize_from_hash(item) }
  end

  def safe_file
    exist = File.exist?("#{Helper::DIRNAME}/#{self.class_variable_get(:@@filename)}")
    self.init_file unless exist
  end

  def write_to_disk(data, file_name)
    file = File.new("#{Helper::DIRNAME}/#{file_name}", "w+")
    file.syswrite(data.to_json)
    file.close
  end

  def read_from_disk(file_name)
    arr = []
    file = File.new("#{Helper::DIRNAME}/#{file_name}", "r")
    file.each do |line|
      arr = JSON.parse(line)
    end
    file.close
    arr
  end
end