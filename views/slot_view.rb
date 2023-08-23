class SlotView
  def self.active(activated = true)
    puts <<END
-------------------------------
 Slot #{activated ? "r" : "d"}eactivated successfully 
-------------------------------
END
  end

  def self.added(increment)
    puts <<END
--------------------------------
 #{increment} Slots added successfully
--------------------------------
END
  end
end