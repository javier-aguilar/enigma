class Enigma

  def initialize()
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

end
