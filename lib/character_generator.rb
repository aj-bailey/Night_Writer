require 'csv'
require_relative 'character'

class CharacterGenerator
  def self.create_braille_characters(path)
    characters = []

    CSV.foreach(path, headers: true, header_converters: :symbol ) do |info|
      characters << Character.new(info)
    end

    characters
  end
end