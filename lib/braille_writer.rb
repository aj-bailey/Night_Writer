require_relative 'character_writer'

class BrailleWriter < CharacterWriter
  def translate
    write_file(convert_text(read_file))
    "Created '#{@write_path}' containing #{read_file.length} characters"
  end

  def convert_text(alphabetical_text)
    validated_text = invalidate_characters(alphabetical_text)

    lines_of_text = validated_text.scan(/.{1,40}/) 

    lines_of_braille_to_string(lines_of_braille(lines_of_text))
  end

  def invalidate_characters(alphabetical_text)
    alphabetical_text.gsub!("\n", " ")
    alphabetical_text.chars.reject { |character| !@chars.group_by(&:letter).include?(character) }.join
  end

  def lines_of_braille(lines_of_text)
    lines_of_text.map { |line| line.chars.map { |char| char_to_braille(char) } }
  end

  def lines_of_braille_to_string(lines_of_braille)
    lines_of_braille.map do |braille_line|
      braille_line.transpose.map { |line| line.join(" ")}.join("\n").concat("\n")
    end.join("\n").chomp
  end

  def char_to_braille(char)
    chars_grouped_by_letter = @chars.group_by(&:letter)

    [
      chars_grouped_by_letter[char][0].top_row, 
      chars_grouped_by_letter[char][0].middle_row, 
      chars_grouped_by_letter[char][0].bottom_row
    ]
  end
end