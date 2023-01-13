require 'csv'
require_relative 'braille_char'

class BrailleCharGenerator
  def self.create_braille_characters(path)
    braille_chars = []

    CSV.foreach(path, headers: true, header_converters: :symbol ) do |info|
      braille_chars << BrailleChar.new(info)
    end

    braille_chars
  end
end