require_relative "braille_char_generator"

class BrailleWriter
  attr_reader :read_path, 
              :write_path,
              :chars

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
    @chars = BrailleCharGenerator.create_braille_characters('braille_characters.csv')

    p translate
  end

  def translate
    create_file
    "Created '#{@write_path}' containing #{File.open(@read_path).read.length} characters"
  end

  def create_file
    # require "pry"; binding.pry
    
  end
end