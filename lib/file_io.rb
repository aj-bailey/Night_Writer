require_relative "character_generator"

class FileIO
  attr_reader :read_path,
              :write_path,
              :chars

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
    @chars = CharacterGenerator.create_braille_characters('./lib/characters.csv')
  end

  def read_file
    File.read(@read_path)
  end

  def write_file(text)
    File.write(@write_path, text)
  end
end