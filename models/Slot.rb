require_relative '../utils/exceptions'

class Slot
  attr_accessor :occupied, :slot_no

  def initialize(slot_no: , occupied: false)
    @occupied = occupied
    @slot_no = slot_no
  end
end