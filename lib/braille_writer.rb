require_relative "braille_char_generator"

class BrailleWriter
  attr_reader :read_path, 
              :write_path,
              :chars

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
    @chars = BrailleCharGenerator.create_braille_characters('braille_characters.csv')
  end

  def translate
    write_file(convert_text(read_file))
    "Created '#{@write_path}' containing #{read_file.length} characters"
  end

  def read_file
    File.open(@read_path).read
  end


  def write_file(text)
    File.open(@write_path, 'w').write(text)
  end

  def convert_text(text)
    chars_grouped_by_letter = @chars.group_by(&:letter)
    validated_text = invalidate_characters(text)
    braille_text = ""
    sets_of_40 = text.length / 40

    (sets_of_40 + 1).times do |i|
      starting_index = i * 40
      ending_index = (40 * (i + 1)) - 1

      braille_text << validated_text[starting_index..ending_index].chars.map { |letter| chars_grouped_by_letter[letter][0].top_row + " " }.join.concat("\n")
      braille_text << validated_text[starting_index..ending_index].chars.map { |letter| chars_grouped_by_letter[letter][0].middle_row + " " }.join.concat("\n")
      braille_text << validated_text[starting_index..ending_index].chars.map { |letter| chars_grouped_by_letter[letter][0].bottom_row + " " }.join.concat("\n\n")
    end
    
    braille_text.chomp.chomp
  end

  def invalidate_characters(text)
    text.gsub!("\n", " ")
    text.chars.reject { |character| !@chars.group_by(&:letter).include?(character) }.join
  end
end