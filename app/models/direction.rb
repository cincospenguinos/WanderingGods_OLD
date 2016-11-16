# direction.rb
#
# Class that simply has a bunch of directions.
module Direction
  NORTH = 0
  NORTH_EAST = 1
  EAST = 2
  SOUTH_EAST = 3
  SOUTH = 4
  SOUTH_WEST = 5
  WEST = 6
  NORTH_WEST = 7
  UP = 8
  DOWN = 9

  def self.is_direction?(dir)
    if dir.is_a?(String)
      # TODO: String checks
    elsif dir.is_a?(Integer)
      return true if dir >= 0 && dir <= 9
    end

    false
  end
end