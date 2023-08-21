require "json"
require_relative './helper'

module ModelHelper

  def write_data_to_file(data)
    arr = []
    data.each do |item|
      arr << item.create_hash
    end

    file = File.new("#{Helper::DIRNAME}/#{self.class_variable_get(:@@filename)}", "w+")
    file.syswrite(arr.to_json)
    file.close
  end

  def read_data_from_file
    arr = []
    file = File.new("#{Helper::DIRNAME}/#{self.class_variable_get(:@@filename)}", "r")
    file.each do |line|
      data = JSON.parse(line)
      data.each do |item|
        arr << self.create_object_from_hash(item)
      end
    end

    file.close
    arr
  end

  def safe_file
    exist = File.exist?("#{Helper::DIRNAME}/#{self.class_variable_get(:@@filename)}")
    self.init_file unless exist
  end
end