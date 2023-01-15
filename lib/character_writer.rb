require_relative "braille_char_generator"

class CharacterWriter
  attr_reader :read_path,
              :write_path,
              :chars

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
    @chars = BrailleCharGenerator.create_braille_characters('braille_characters.csv')
  end

  def read_file
    File.open(@read_path).read
  end

  def write_file(text)
    File.open(@write_path, 'w').write(text)
  end
end