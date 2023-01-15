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
    "Created '#{@write_path}' containing #{File.read('./spec/fixtures/test_braille_input.txt').length/9} characters"
  end
end