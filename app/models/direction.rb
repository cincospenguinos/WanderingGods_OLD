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
      return %w(n ne e se s sw w nw u d north northeast east southeast south southwest west northwest up down).include?(dir.downcase)
    elsif dir.is_a?(Integer)
      return true if dir >= 0 && dir <= 9
    end

    false
  end

  def self.to_s(dir)
    case dir
      when NORTH
        'north'
      when NORTH_EAST
        'northeast'
      when EAST
        'east'
      when SOUTH_EAST
        'southeast'
      when SOUTH
        'south'
      when SOUTH_WEST
        'south'
      when WEST
        'west'
      when NORTH_WEST
        'northwest'
      else
        nil
    end
  end
end