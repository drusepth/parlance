#!/usr/bin/ruby
require 'pry'

START_QUOTE         = '"'
END_QUOTE           = '"'
DIALOGUE_REGEX      = /#{START_QUOTE}[^#{START_QUOTE}]+#{END_QUOTE}/
SPEAKER_NAME_REGEX  = /[A-Z][\w\.-]*\s+[A-Z][\w-]*+/
SPEAKING_VERBS      = ['said', 'chortled']
SPEAKING_VERB_REGEX = /[#{SPEAKING_VERBS.join('|')}]/
SPEAKER_ANNOTATIONS = [
  /#{SPEAKING_VERB_REGEX} (#{SPEAKER_NAME_REGEX})/,
  /(#{SPEAKER_NAME_REGEX}) #{SPEAKING_VERB_REGEX}/
]

unless book_path = ARGV.shift
  puts "Usage: $0 <path/to/book.txt>"
  exit
end

def dialogue_in_text text
  text.scan DIALOGUE_REGEX
end

def speaker_in_text text
  SPEAKER_ANNOTATIONS.each do |regex|
    match = text.scan regex
    return match.flatten[0] if match.any?
  end

  return nil
end

binding.pry

File.open(book_path, "r") do |f|
  f.each_line do |line|
    #puts line

    # Finding any dialogue
    dialogue = dialogue_in_text(line)
    next unless dialogue.any?

    # Find any potential speaker
    speaker = speaker_in_text(line)

    puts "<#{speaker}> #{dialogue}"
  end
end
