filename = 'google-10000-english-no-swears.txt'
abort("Could not open file #{filename}!") unless File.exist?(filename)

dictionary = File.open(filename, 'r')

def words_by_length(file, min_size, max_size)
  possible_words = file.select { |w| w.chomp.length.between?(min_size, max_size) }
end

def define_word(file)
  available_words = words_by_length(file, 5, 12)
  random = rand(0..available_words.length)
  available_words[random]
end

puts define_word(dictionary)
