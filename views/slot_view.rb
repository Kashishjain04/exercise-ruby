class SlotView
  def self.active(activated = true)
    puts <<END
-------------------------------
 Slot #{activated ? "r" : "d"}eactivated successfully 
-------------------------------
END
  end
end