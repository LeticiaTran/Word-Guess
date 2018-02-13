# NAMES!!
# Ada[9], Ampers
# Week 2: Word Guess Game Assignment
# February 14, 2018
# This program ...

require 'faker' # To generate a new random word from a specific theme.


######################################################################
#CLASS GAME


class Game
  #
  def initialize
    @word = Word.new()
    # @secret_word = generate_random_word#.split("")
    @right_guesses = current_guessed_letters #"" #"_" * @secret_word.length#Array.new(@secret_word.length, "_"),
    @wrong_guesses = []
    @guesses_remaining = 5

  end

  # Get user input for guess:
  def get_input
    print "Please enter a letter to guess > "
    user_input = gets.chomp.strip.downcase
    return if valid_input(user_input).nil?
    process_guess_input(user_input)
    puts current_guessed_letters
    print_wrong_guesses
    print_ascii_art
  end


  def current_guessed_letters
    return @word.generate_random_word.gsub(/[^"#{@right_guesses}\s"]/,"_")
  end

  # # Prints game directions.
  def print_directions
    # TODO: complete
  end

  #
  def game_over?
    return @guesses_remaining == 0 || @word.guessed_right_word(@right_guesses) # || @secret_word == current_guessed_letters
  end

  #
  def display_end_of_game
    if game_over?
      #@secret_word == current_guessed_letters ?
      @word.guessed_right_word(@right_guesses) ? (puts "You won!") : (puts "You lost!")
      puts "Final word: #{@word.secret_word}"
    end
  end

private

#
def print_ascii_art
puts  " #{"(@)" * @guesses_remaining}"
puts "    ,\\,\\,|,/,/,
     _\\\|/_
    |_____|
     |   |
     |___|"
end

def process_guess_input(user_input)
  if @right_guesses.include?(user_input) || @wrong_guesses.include?(user_input)
    puts "You've already guessed #{user_input}."
  elsif @word.has_letter?(user_input) #@secret_word.include?(user_input)
    update_new_guessed_word(user_input)
    puts "Yay!"
  else
    puts "Wrong!"
    @wrong_guesses << user_input
    @guesses_remaining -= 1
  end
end

#
def valid_input(user_input)
  if user_input.length != 1 || !user_input.match?(/[a-z]/)
    puts "Please only enter one letter"
  else
    return user_input
  end
end

#
def update_new_guessed_word(user_input)
   @word.secret_word.length.times {|index| @right_guesses[index] = user_input if user_input == @word.secret_word[index]}
end

#
def print_wrong_guesses
  puts "Wrong guesses: #{@wrong_guesses * ", "}"
end

end


######################################################################
#CLASS WORD


class Word
  attr_reader :secret_word

  def initialize
    @secret_word = generate_random_word#.split("")
  end

  def generate_random_word
    return "hello you"
    # return %w[foo bar baz].sample
  end

  def guessed_right_word(current_guessed_letters)
    puts current_guessed_letters
    puts @secret_word
    @secret_word == current_guessed_letters

  end

  # Prints game directions.
  def has_letter?(user_input)
    return @secret_word.include?(user_input)
  end

end


######################################################################
# FUNCTIONALITY METHODS

#
def play_game
  test_game = Game.new
  test_game.print_directions
  until test_game.game_over?
    test_game.get_input
  end
  test_game.display_end_of_game
end

#
def play_again?
  print "The game is over! Would you like to play again? (Y/N) >"
  play_again_response = gets.chomp.downcase
  return play_again_response == "y" || play_again_response == "yes"
end

play_again = true

while play_again
  play_game
  play_again = play_again?
end
