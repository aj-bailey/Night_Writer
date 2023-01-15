class AlphabetWriter
  attr_reader :read_path, 
              :write_path,
              :chars

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
    @chars = BrailleCharGenerator.create_braille_characters('braille_characters.csv')
  end

  def translate
    file = File.read('./spec/fixtures/test_braille_input.txt')
    number_line_breaks = file.count("\n")
    number_of_characters = (file.length - number_line_breaks) / 9

    "Created '#{@write_path}' containing #{number_of_characters} characters"
  end
end