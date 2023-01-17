class Character
  attr_reader :letter,
              :top_row,
              :middle_row,
              :bottom_row
              
  def initialize(info)
    @letter = info[:letter]
    @top_row = info[:top_row]
    @middle_row = info[:middle_row]
    @bottom_row = info [:bottom_row]
  end
end