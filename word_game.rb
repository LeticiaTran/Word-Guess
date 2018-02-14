# NAMES!!
# Ada[9], Ampers
# Week 2: Word Guess Game Assignment
# February 14, 2018
# This program ...

require 'faker' # To generate a new random word from a specific theme.
require 'colorize' # To change colors on display

######################################################################
#CLASS GAME


class Game
  attr_reader :right_guesses
  #
  def initialize(initial_word)
    @word = initial_word
    @right_guesses = current_guessed_letters
    @wrong_guesses = []
    @guesses_remaining = 5
  end

  # Get user input for guess:
  def get_input
    print "\nPlease enter a letter to guess > ".blue
    return gets.chomp.downcase
  end

  # Print ascii with chances updated, the right guesses and wrong guesses.
  def print_status
    print_ascii_art
    puts right_guesses.green
    print_wrong_guesses
  end

  # Sets the number of guesses raainning to zero.
  def give_up
    guess_full_answer("")
  end

  # Returns true if there are no guesses remainning or if the right word has been found. Otherwise return false.
  def game_over?
    return @guesses_remaining == 0 || @word.guessed_right_word(@right_guesses)
  end

  # If there are no guesses remainning or if the right word has been found prints if the user has won or lost the game. And displays the word that should be guessed.
  def display_end_of_game
    if game_over?
      @word.guessed_right_word(@right_guesses) ? (puts "\n#{"You won!".light_green.bold}") : (puts "You lost!".light_red.bold)
      puts "#{"Final word:".blue} #{@word.secret_word.light_green.bold}"
    end
  end

  #
  def valid_input(user_input)
    return user_input if user_input.length == 1 && user_input.match?(/[a-z]/)
    if user_input.length == @right_guesses.length
      check_if_wants_to_guess_word(user_input)
    end
    puts print_line_in_blue("Please only enter one letter")
  end


  # Prompt the user if wants to use all the guesses remainning to try and guess the whole word(s).
  def check_if_wants_to_guess_word(user_input)
    final_guess = ""
    while final_guess != "y" && final_guess != "n"
      print "Are you sure you want to bet all of your lives on this guess? (y/n)".blue
      final_guess = gets.chomp.downcase
    end
    guess_full_answer(user_input) if final_guess == "y"
  end

  # Runs if user decides to take the cahnce and guess full answer. Sets the guesses remaining to zero and assign the righ_guesse as this final guess if correct.
  def guess_full_answer(final_guess)
    @guesses_remaining = 0
    @right_guesses = final_guess if @word.guessed_right_word(final_guess)
  end

  # Checks if user repeats a previous guessed word and return a warnning message. Otherwise check if guess is right or wrong and displays the result of that guess.
  def process_guess_input(user_input)
    if @right_guesses.include?(user_input) || @wrong_guesses.include?(user_input)
      print_line_in_blue("You've already guessed the letter '#{user_input.bold}'!")
    elsif @word.has_letter?(user_input) #@secret_word.include?(user_input)
      update_new_guessed_word(user_input)
      puts "Yay!".green.bold
    else
      puts "Wrong!".red.bold
      @wrong_guesses << user_input
      @guesses_remaining -= 1
    end
  end

private

# Set string with color blue
def print_line_in_blue(text_to_print)
  puts "#{text_to_print}".blue
end

def current_guessed_letters
  return @word.secret_word.gsub(/[^"#{@right_guesses}\s\W"]/,"_")
end

#
def print_ascii_art
  empty_space = "    "
  larger_empty_space = "     "
  if @guesses_remaining == 1
    puts "\n(@)".red.blink
  else
    puts  "\n#{"(@)" * @guesses_remaining}".red
  end
  puts "  ,\\,\\,|,/,/,".green
  puts "     _\\\|/_".green
  print empty_space
  puts"|_____|".yellow.on_light_yellow
  print larger_empty_space
  puts "|   |".yellow.on_light_yellow
  print larger_empty_space
  puts "|___|".yellow.on_light_yellow
  puts
end

#
def update_new_guessed_word(user_input)
  @word.secret_word.length.times { |index| @right_guesses[index] =
    @word.secret_word[index] if @word.secret_word[index].downcase == user_input }
end

#
def print_wrong_guesses
  puts "Wrong guesses: #{@wrong_guesses * ", "}".red if !@wrong_guesses.empty?
end

end


######################################################################
#CLASS WORD


class Word
  attr_reader :secret_word, :difficulty_level

  def initialize(initial_difficulty_level)
    @difficulty_level = initial_difficulty_level
    @secret_word = generate_random_word
  end

  def generate_random_word
    case @difficulty_level
    when "easy"
      return Faker::Movie.quote
    when "medium"
      return Faker::Food.dish
    when "hard"
      return Faker::Color.color_name
    end
  end

  def guessed_right_word(current_letters)
    return @secret_word.casecmp?(current_letters)
  end

  # Prints game directions.
  def has_letter?(user_input)
    return @secret_word.downcase.include?(user_input)
  end

end


######################################################################
# FUNCTIONALITY METHODS

def get_difficulty_level
  difficulty = ""
  until difficulty == "easy" ||  difficulty == "medium" || difficulty == "hard"
    print "Please select a difficulty level (easy, medium, hard) > ".blue
    difficulty = gets.chomp.strip
  end
  return difficulty
end


def print_in_blue(text_to_print)
  print "#{text_to_print}".blue
end

def handle_input(input_letter)
  if input_letter == "exit"
    print "Are you sure you want to exit? (y/n) >".blue
    exit if gets.chomp.downcase == "y"
  end
end


# Prints a welcome message and game directions.
def print_directions
  puts
print_in_blue("Welcome to the Word Guess Game!\n\n")
print_in_blue("When prompted for a letter, type #{"exit".bold} to quit the program or")
print_in_blue("#{"restart".bold} to give up and start a new game.")
print_in_blue("This game has three difficulty levels with different themes:")
print_in_blue("#{'Easy'.bold} is random movie quotes.")
print_in_blue("#{'Medium'.bold} is random dishes.")
print_in_blue("#{'Hard'.bold} is random color.\n\n")
end




def print_in_blue(text_to_print)
  puts "#{text_to_print}".center(60).blue
end


#
def play_game
  print_directions
  difficulty_level = get_difficulty_level
  word_game = Game.new(Word.new(difficulty_level))
  until word_game.game_over?
    word_game.print_status
    input_letter = word_game.get_input
    handle_input(input_letter)
    if input_letter == "restart"
      word_game.give_up
      break
    end
    next if !word_game.valid_input(input_letter)
    word_game.process_guess_input(input_letter)
  end
  word_game.display_end_of_game
end

#
def play_again?
  print_in_blue("\nThe game is over! Would you like to play again? (Y/N) >")
  play_again_response = gets.chomp.downcase
  return play_again_response == "y" || play_again_response == "yes"
end

play_again = true

while play_again
  play_game
  play_again = play_again?
end
