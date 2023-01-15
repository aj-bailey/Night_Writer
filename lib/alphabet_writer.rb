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
    file = read_file
    number_line_breaks = file.count("\n")
    number_of_characters = (file.length - number_line_breaks) / 9

    write_file(convert_text(file))

    "Created '#{@write_path}' containing #{number_of_characters} characters"
  end

  def read_file
    File.open(@read_path).read
  end

  def write_file(text)
    File.open(@write_path, 'w').write(text)
  end

  def convert_text(text)
    alphabet_text = ""
    sets_of_three_braille_lines = [] 

    chars_group_by_braille_letter = @chars.group_by do |char|
      [char.top_row, char.middle_row, char.bottom_row]
    end.transform_values! { |char| char.first.letter }

    validated_text = invalidate_characters(text)

    lines = validated_text.split("\n").map do |line|
      line.scan(/../)
    end

    (lines.length / 3).times do |index|
      starting_index = index * 3
      ending_index = (index * (3)) + 2

      sets_of_three_braille_lines << lines[starting_index..ending_index]
    end

    sets_of_three_braille_lines.each do |set_of_three_braille_lines|
      set_of_three_braille_lines.transpose.each do |braille_character|
        alphabet_text << chars_group_by_braille_letter[braille_character]
      end
      alphabet_text << "\n"
    end

    alphabet_text.chomp
  end

  def invalidate_characters(text)
    text.delete!(" ")
    text.gsub!("\n\n", "\n")
    text
  end
end