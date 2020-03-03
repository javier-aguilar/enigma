require './test/test_helper'
require './lib/enigma'

class ComputableTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def test_it_can_return_todays_date
    today = Date.new(2020, 03, 02) #March 2, 2020
    Date.today.stubs(:now).returns(today)
    expected = "020320" #DDMMYY format

    assert_equal expected, @enigma.current_date
  end

  def test_it_can_square_date
    expected = "412902400"
    
    assert_equal expected, @enigma.square_date("020320")
  end

  def test_it_can_generate_randomize_five_digits
    number = @enigma.randomize_five_digits

    assert (0..99999).include?(number.to_i)
    assert_equal 5, number.length
  end

end
