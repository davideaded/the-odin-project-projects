filename = 'google-10000-english-no-swears.txt'
abort("Could not open file #{filename}!") unless File.exist?(filename)

dictionary = File.open(filename, 'r')

def words_by_length(file, min_size, max_size)
  possible_words = file.select { |w| w.chomp.length.between?(min_size, max_size) }
end

def define_word(file)
  available_words = words_by_length(file, 5, 12)
  random = rand(0..available_words.length)
  available_words[random].chomp
end

def print_guess
  occult_word = ''
  chances = 5

  until occult_word.length == CORRECT_WORD.length do
    occult_word << '_'
  end

  puts occult_word
  loop do
    guess = gets.chomp
    correct_guess = false

    CORRECT_WORD.split("").each_with_index do |l, i|
      (occult_word[i] = guess) && (correct_guess = true) if l == guess && occult_word[i] == '_'
    end

    chances -= 1 if !correct_guess
    puts "#{occult_word}\t #{chances} chances"
    break if chances == 0 || !occult_word.include?('_')
  end

  puts occult_word
end

CORRECT_WORD = define_word(dictionary)
puts CORRECT_WORD
print_guess













# def write_to_file(dictionary)
#   words_arr = words_by_length(dictionary, 5, 12)
#   file = File.open('output.txt', 'w')
#   words_arr.each do |word|
#     file.write(word)
#   end
# end

