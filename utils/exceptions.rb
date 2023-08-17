class InvalidRegNo < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

class NoSlotAvailable < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

class CarNotFound < StandardError
end

class InvoiceNotFound < StandardError
end