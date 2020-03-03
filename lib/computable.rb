module Computable
  
  def current_date
    Date.today.strftime "%d%m%y"
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

  def square_date(date)
    (date.to_i ** 2).to_s
  end

end
