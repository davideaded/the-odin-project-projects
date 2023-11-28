filename = 'google-10000-english-no-swears.txt'
abort("Could not locate file #{filename}!") unless File.exist?(filename)

DICTIONARY = File.open(filename, 'r')

def words_by_length(min_size, max_size)
  possible_words = DICTIONARY.select { |w| w.chomp.length.between?(min_size, max_size) }
end

AVAILABLE_WORDS = words_by_length(5, 12)

def define_word
  random = rand(0..AVAILABLE_WORDS.length)
  AVAILABLE_WORDS[random].chomp
end

def occult_word(original_word)
  word = ''
  until word.length == original_word.length do
    word << '_'
  end

  word
end

def start_game(chances)
  correct_word = define_word
  occulted_word = occult_word(correct_word)
  guesses = []
  
  loop do
    puts "Enter a letter:"
    guess = gets.chomp
    if guesses.include?(guess)
      puts "Already used letter!"
      next
    end
    correct_guess = false
    guesses.push(guess)

    correct_word.split("").each_with_index do |l, i|
      (occulted_word[i] = guess) && (correct_guess = true) if l == guess && occulted_word[i] == '_'
    end

    chances -= 1 if !correct_guess
    puts "Used letters: #{guesses}"
    puts "#{occulted_word}\t #{chances} chances"
    break if chances == 0 || !occulted_word.include?('_')
  end

  occulted_word.include?('_') ? (puts "You lost! The word was: #{correct_word}") : (puts "You won!")
end

def init_game
  chances = 5
  start_game(chances)
  response = ''

  while response != 'n' do 
    puts "Play again? (Y/N)"
    response = gets.chomp.downcase
    start_game(chances) if response == 'y'
  end
end

init_game
