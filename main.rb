#!/usr/bin/ruby
require 'pry'

START_QUOTE = '"'
END_QUOTE   = '"'
DIALOGUE_REGEX = /#{START_QUOTE}[^#{START_QUOTE}]+#{END_QUOTE}/

unless book_path = ARGV.shift
  puts "Usage: $0 <path/to/book.txt>"
  exit
end

def dialogue_in_text text
  text.scan DIALOGUE_REGEX
end


File.open(book_path, "r") do |f|
  f.each_line do |line|
    #puts line

    # Finding any dialogue
    dialogue = dialogue_in_text(line)
    next unless dialogue.any?

    puts "Dialogue found: #{dialogue}"
  end
end
