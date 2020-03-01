class Enigma

  def initialize()
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

  def generate_keys(five_digit_num)
    {
      A: five_digit_num[0..1],
      B: five_digit_num[1..2],
      C: five_digit_num[2..3],
      D: five_digit_num[3..4]
    }
  end

  def generate_offsets(date)
    squared_date = (date.to_i * date.to_i)
    offsets = squared_date.to_s.slice(-4, 4)
    {
      A: offsets[0],
      B: offsets[1],
      C: offsets[2],
      D: offsets[3]
    }
  end

end
