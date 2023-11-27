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

def occult_word
  word = ''
  until word.length == CORRECT_WORD.length do
    word << '_'
  end

  word
end

def start_game(word, chances)
  loop do
    guess = gets.chomp
    correct_guess = false

    CORRECT_WORD.split("").each_with_index do |l, i|
      (word[i] = guess) && (correct_guess = true) if l == guess && word[i] == '_'
    end

    chances -= 1 if !correct_guess
    puts "#{word}\t #{chances} chances"
    break if chances == 0 || !word.include?('_')
  end
end

def init_game
  chances = 5
  occulted_word = occult_word

  puts occulted_word
  start_game(occulted_word, chances)
end

CORRECT_WORD = define_word(dictionary)
init_game
