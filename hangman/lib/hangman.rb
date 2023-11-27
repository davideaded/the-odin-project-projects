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

# def write_to_file(dictionary)
#   words_arr = words_by_length(dictionary, 5, 12)
#   file = File.open('output.txt', 'w')
#   words_arr.each do |word|
#     file.write(word)
#   end
# end

