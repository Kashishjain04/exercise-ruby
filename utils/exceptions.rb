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
  def initialize(msg = nil)
    super("Car not found")
  end
end

class InvoiceNotFound < StandardError
  def initialize(msg = nil)
    super("Invoice not found")
  end
end