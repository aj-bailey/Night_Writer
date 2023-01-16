require_relative 'character_writer'

class AlphabetWriter < CharacterWriter
  def translate
    file = read_file
    number_line_breaks = file.count("\n")
    number_of_characters = (file.length - number_line_breaks) / 9

    write_file(convert_text(file))

    "Created '#{@write_path}' containing #{number_of_characters} characters"
  end

  def convert_text(text)
    validated_text = invalidate_characters(text)
    lines_of_braille = lines_of_braille(validated_text)
    sets_of_three_braille_lines = sets_of_three_braille_lines(lines_of_braille)
    
    alphabet_text = ""
    sets_of_three_braille_lines.each do |set_of_three_braille_lines|
      set_of_three_braille_lines.transpose.each do |braille_character|
        alphabet_text << braille_char_to_alphabetical(braille_character)
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

  def braille_char_to_alphabetical(braille_character)
    chars_group_by_braille_letter = @chars.group_by do |char|
      [char.top_row, char.middle_row, char.bottom_row]
    end.transform_values! { |char| char.first.letter }

    chars_group_by_braille_letter[braille_character]
  end

  def lines_of_braille(text)
    text.split("\n").map { |line| line.scan(/../) }
  end

  def sets_of_three_braille_lines(lines_of_braille)
    lines_of_braille.each_slice(3).to_a
  end
end