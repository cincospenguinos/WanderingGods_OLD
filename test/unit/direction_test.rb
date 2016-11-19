require 'test/unit'

require_relative '../../app/models/direction'

class DirectionTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
  end

  def test_is_direction
    strings = %w(n ne northfeast UP dOwN Southwest nope)
    numbers = [0, 1, 10, 4, 7, 3, -1]
    values = [true, true, false, true, true, true, false]

    i = 0
    strings.each do |s|
      assert_equal(Direction.is_direction?(s), values[i])
      i += 1
    end

    i = 0
    numbers.each do |n|
      assert_equal(Direction.is_direction?(n), values[i])
      i += 1
    end
  end
end