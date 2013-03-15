require 'ProcessLog'
require 'test/unit'

class ProcessLogTest < Test::Unit::TestCase

  def setup
    @array=[{:name=>"foo"}]
  end

  def test_find_element_in_array
    assert_not_nil(get_node(@array,"foo"))
  end

  def test_element_not_in_array
    assert_nil(get_node(@array, "bar"))
  end

end