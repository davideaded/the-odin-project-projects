class Player
  attr_accessor :guess, :guesses

  def initialize
    self.guesses = []
  end

  def make_guess
    letter = gets.chomp.downcase
    checked_guess = check_player_guess(letter, self.guesses)
    self.guesses.push(checked_guess) if checked_guess != nil
    self.guess = checked_guess
  end

  def check_player_guess(guess, guesses)
    if guess.length != 1 || guess == ""
      puts "#{guess} must be one letter!"
      return nil
    end

    if guesses.include?(guess)
      puts guesses.include?(guess)
      puts "Already used letter!"
      return nil
    end

    guess
  end

  def clear_guesses
    self.guesses = []
  end
end

class Dictionary
  attr_accessor :dictionary, :available_words
  FILENAME = 'google-10000-english-no-swears.txt'

  def initialize
    abort("Could not locate file #{FILENAME}!") unless File.exist?(FILENAME)
    self.dictionary = File.open(FILENAME, 'r')
    self.available_words = words_by_length
  end

  def words_by_length
    min_size = 5
    max_size = 12
    possible_words = self.dictionary.select { |w| w.chomp.length.between?(min_size, max_size) }
  end

  def define_word
    random = rand(0..self.available_words.length)
    self.available_words[random].chomp
  end

  def occult_word(original_word)
    word = ''
    until word.length == original_word.length do
      word << '_'
    end
    word
  end
end

class Game
  attr_accessor :player, :dictionary

  def initialize
    self.player = Player.new
    self.dictionary = Dictionary.new
  end

  def start_game(correct_word, occulted_word)
    chances = 5
    loop do
      puts "Enter a letter:"
      guess = player.make_guess

      next if !guess.is_a?(String)
      correct_guess = false

      correct_word.split("").each_with_index do |l, i|
        (occulted_word[i] = guess) && (correct_guess = true) if l == guess && occulted_word[i] == '_'
      end

      chances -= 1 if !correct_guess
      puts "Used letters: #{player.guesses}"
      puts "#{occulted_word}\t #{chances} chances"
      break if chances == 0 || !occulted_word.include?('_')
    end
    occulted_word.include?('_') ? (puts "You lost! The word was: #{correct_word}") : (puts "You won!")
  end

  def init_game
    correct_word = dictionary.define_word
    occulted_word = dictionary.occult_word(correct_word)
    response = ''

    start_game(correct_word, occulted_word)

    while response != 'n' do 
      puts "Play again? (Y/N)"
      response = gets.chomp.downcase
      if response == 'y'
        correct_word = dictionary.define_word
        occulted_word = dictionary.occult_word(correct_word)
        player.clear_guesses
        start_game(correct_word, occulted_word)
      end
    end
  end
end

game = Game.new
game.init_game
