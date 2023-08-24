class InvalidRegNo < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

class InvalidPhoneNo < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

class NoSlotAvailable < StandardError
  def initialize(msg = nil)
    super(msg)
  end
end

class InvalidSlotId < StandardError
  def initialize(msg = nil)
    super("Invalid slot Id")
  end
end
class CarAlreadyParked < StandardError
  def initialize(msg = nil)
    super("Car already parked")
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

class SlotActive < StandardError
  def initialize(msg)
    super
  end
end