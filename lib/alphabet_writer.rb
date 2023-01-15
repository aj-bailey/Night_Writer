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

  def read_file
    File.open(@read_path).read
  end

  def write_file(text)
    File.open(@write_path, 'w').write(text)
  end

  def convert_text(text)
    chars_group_by_braille_letter = @chars.group_by do |char|
      [char.top_row, char.middle_row, char.bottom_row]
    end.transform_values! { |char| char.first.letter }

    validated_text = invalidate_characters(text)
    alphabet_text = ""
    lines = validated_text.split("\n").map do |line|
      line.scan(/../)
    end
    
    lines.map.with_index { |line, index| chars_group_by_braille_letter[lines.transpose[index]] }.join    
  end

  def invalidate_characters(text)
    text.delete!(" ")
    text.gsub!("\n\n", "\n")
    text
  end
end