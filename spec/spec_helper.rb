require_relative '../helpers/helper'
require_relative '../helpers/model_helper'
require_relative '../utils/exceptions'
require_relative '../controllers/parking_lot_controller'
require_relative '../models/car'
require_relative '../models/invoice'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = 'random'


  config.before do
      allow(Helper).to receive(:safe_file)

      allow(Car).to receive(:write_to_disk)
      allow(Invoice).to receive(:write_to_disk)
      allow(Slot).to receive(:write_to_disk)

      allow(Car).to receive(:read_from_disk).and_return([])
      allow(Slot).to receive(:read_from_disk).and_return([{ "slot_no" => 1, "active" => true },
                                                          { "slot_no" => 2, "active" => true },
                                                          { "slot_no" => 3, "active" => true }])
      allow(Invoice).to receive(:read_from_disk).and_return([])
  end
end
