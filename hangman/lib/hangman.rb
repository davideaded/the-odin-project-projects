require 'yaml'

class Player
  attr_accessor :guess, :guesses

  def initialize
    self.guesses = []
  end

  def make_guess
    letter = gets.chomp.downcase
    checked_guess = check_player_guess(letter, self.guesses)
    self.guesses.push(checked_guess) if checked_guess != nil && checked_guess != '0'
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
  attr_accessor :correct_word, :occulted_word
  FILENAME = 'google-10000-english-no-swears.txt'

  def initialize
    abort("Could not locate file #{FILENAME}!") unless File.exist?(FILENAME)
    @correct_word = define_word
    @occulted_word = occult_word(@correct_word)
  end

  def words_by_length
    dictionary = File.open(FILENAME, 'r')
    min_size = 5
    max_size = 12
    possible_words = dictionary.select { |w| w.chomp.length.between?(min_size, max_size) }
  end

  def define_word
    available_words = words_by_length
    random = rand(0..available_words.length)
    available_words[random].chomp
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

  def initialize(player = Player.new, dictionary = Dictionary.new)
    @player = player
    @dictionary = dictionary
  end

  def check_guess(guess)
    correct_word = dictionary.correct_word
    occulted_word = dictionary.occulted_word

    correct_word.split("").each_with_index do |l, i|
      occulted_word[i] = guess if l == guess && occulted_word[i] == '_'
    end

    occulted_word
  end

  def save_game
    data = { 'player' => @player, 'dictionary' => @dictionary }
    dump = YAML.dump(data)
    File.open('savegame.yaml', 'w') { |file| file.write dump }
    exit(0)
  end

  def start_game
    chances = 7
    puts dictionary.occulted_word
    puts "Used letters: #{player.guesses}"
    loop do
      puts "Enter a letter or press '0' to save current game"
      guess = player.make_guess
      save_game if guess == '0'
      if !guess.is_a?(String)
        puts occulted_word
        next
      end
      occulted_word = check_guess(guess)

      chances -= 1 if !occulted_word.include?(guess)
      puts "Used letters: #{player.guesses}"
      puts "#{occulted_word}\t #{chances} chances"
      break if chances == 0 || !occulted_word.include?('_')
    end
    dictionary.occulted_word.include?('_') ? (puts "You lost! The word was: #{dictionary.correct_word}") : (puts "You won!")
  end
end

def load_save
  if !File.exist?('savegame.yaml')
    puts "No save data found! Starting a new game!"
    return Player.new, Dictionary.new
  end

  file = File.read('savegame.yaml')
  saved_data = YAML.safe_load(file, permitted_classes: [Player, Dictionary, Game])
  player_data = saved_data['player']
  dictionary_data = saved_data['dictionary']
  return player_data, dictionary_data
end

loop do
  puts "Hangman game! \nSelect: 1) Play 2) Load game"
  select = gets.chomp

  until ['1', '2'].include?(select)
    puts "Invalid selection!"
    select = gets.chomp
  end

  if select == '2'
    player, dictionary = load_save
    game = Game.new(player, dictionary)
    else
      game = Game.new
  end
  game.start_game
  puts "Play again? (y/n)"
  response = gets.chomp.downcase
  break if response == 'n'
end
