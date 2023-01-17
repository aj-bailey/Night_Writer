require_relative 'file_io'

class NightReader < FileIO
  def translate
    write_file(convert_text(read_file))

    output_file = File.read(@write_path)
    number_line_breaks = output_file.count("\n")
    number_of_characters = output_file.length - number_line_breaks

    "Created '#{@write_path}' containing #{number_of_characters} characters"
  end

  def convert_text(braille_text)
    validated_text = invalidate_characters(braille_text)
    lines_of_braille = lines_of_braille(validated_text)
    sets_of_three_braille_lines = sets_of_three_braille_lines(lines_of_braille)

    convert_to_alphabetical(sets_of_three_braille_lines)
  end

  def invalidate_characters(braille_text)
    braille_text.delete!(" ")
    braille_text.gsub!("\n\n", "\n")
    braille_text
  end

  def braille_char_to_alphabetical(braille_character)
    chars_group_by_braille_letter = @chars.group_by do |char|
      [char.top_row, char.middle_row, char.bottom_row]
    end.transform_values! { |char| char.first.letter }

    chars_group_by_braille_letter[braille_character]
  end

  def lines_of_braille(braille_text)
    braille_text.split("\n").map { |line| line.scan(/../) }
  end

  def sets_of_three_braille_lines(lines_of_braille)
    lines_of_braille.each_slice(3).to_a
  end

  def convert_to_alphabetical(sets_of_three_braille_lines)
    uppercase_placeholder = false

    sets_of_three_braille_lines.map do |set_of_three_braille_lines| 
      set_of_three_braille_lines.transpose.map do |braille_character|
        if braille_char_to_alphabetical(braille_character) == "uppercase"
          uppercase_placeholder = true
        else
          if uppercase_placeholder
            uppercase_placeholder = false
            braille_char_to_alphabetical(braille_character).upcase
          else
            braille_char_to_alphabetical(braille_character)
          end
        end
      end.join.gsub("true","")  
    end.join("\n")
  end
end