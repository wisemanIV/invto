require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  test "is valid phone" do 
    assert Message.is_valid_phone('4154200068')
    assert Message.is_valid_phone('14154200068')
    assert Message.is_valid_phone('+14154200068')
    assert !Message.is_valid_phone('0154200068')
    assert !Message.is_valid_phone('72154200068')
    assert !Message.is_valid_phone('472154200068')
    assert !Message.is_valid_phone('470068')
  end
  
  test "clean phone number" do 
    assert_equal Message.clean_phone_number('+1 (415) 420 0068'), "+14154200068"
    assert_equal Message.clean_phone_number('415-420-0068'), "4154200068"
    assert_equal Message.clean_phone_number('+1 4154200068'), "+14154200068"
    assert_equal Message.clean_phone_number('415-[420] 0068'), "4154200068"
    assert_equal Message.clean_phone_number('+1 415.420.0068'), "+14154200068"
    assert_equal Message.clean_phone_number('415.420.0 0 6 8'), "4154200068"
    assert_equal Message.clean_phone_number('#415 420*0068'), "4154200068"
    assert_equal Message.clean_phone_number(' +1415420-0068 '), "+14154200068"
  end
  
  test "get country code" do 
    assert_equal Message.get_country_code('4154200068'), "+1"
    assert_equal Message.get_country_code('+444154200068'), "+4"
    assert_equal Message.get_country_code('+14154200068'), "+1"
  end
  
  test "less country code" do 
    assert_equal Message.less_country_code('+14154200068'), "4154200068"
    assert_equal Message.less_country_code('4154200068'), "4154200068"
    assert_equal Message.less_country_code('+444154200068'), "44154200068"
  end
end