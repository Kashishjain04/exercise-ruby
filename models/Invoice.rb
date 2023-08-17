class Invoice
  attr_accessor :car_reg_no, :slot_no, :entry_time, :exit_time, :duration, :amount

  def initialize(car_reg_no: , slot_no: , entry_time: , exit_time: , duration: nil, amount: nil)
    @car_reg_no = car_reg_no
    @slot_no = slot_no
    @entry_time = entry_time
    @exit_time = exit_time
    @duration = Integer(exit_time - entry_time)
    @amount = calc_amount
  end
  
  def calc_amount
    case @duration
    when ..10
      100
    when 11..30
      200
    when 31..60
      300
    else
      500
    end
  end

  def print
    puts <<-END
------------------------------------------------
Your Invoice
      Car Registration Number: #{@car_reg_no}
      Duration: #{@duration} seconds
      Entry: #{@entry_time}
      Exit: #{@exit_time}
      Amount: #{@amount}
------------------------------------------------
    END
  end
end