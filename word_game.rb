# test_game = Game.new

# test_gam
# word_array = ["b", "a", "r"]



# # # word_hidden = "___"
# word = "bar"
# right_guesses = "a"
#
# # puts "#{word - right_guesses}"
#
#



class Game


  def initialize
    @secret_word = generate_random_word#.split("")
    @right_guesses = ""#"_" * @secret_word.length#Array.new(@secret_word.length, "_"),
    @wrong_guesses = []
    @guesses_remaining = 5

  end

  def get_input
    print "Please enter a letter to guess > "
    user_input = gets.chomp.strip
    process_guess_input(user_input)
    puts current_guessed_letters
    print_ascii_art
  end

  def current_guessed_letters
    return @secret_word.gsub(/[^"#{@right_guesses}"]/,"_")
    # puts @secret_word.join.gsub(/[^"#{@right_guesses}"]/,"_")
  end

  # Prints game directions.
  def print_directions
    # TODO: complete
  end

  def game_over?
    return @guesses_remaining == 0 || @secret_word == current_guessed_letters
  end

  def play_again?
    if game_over?
      print "The game is over! Would you like to play again? (Y/N) >"
      play_again_response = get.chomp.downcase
      return play_again_response == "y" || play_again_response == "yes"
    end
  end


private

  def valid_input(user_input)
    # if
  end

  def process_guess_input(user_input)
    if @right_guesses.include?(user_input) || @right_guesses.include?(user_input)
      puts "You've already guessed #{user_input}."
    elsif @secret_word.include?(user_input)
      @right_guesses = "#{@right_guesses}#{user_input}"
    else
      @wrong_guesses << user_input
      @guesses_remaining -= 1
    end
  end

  def print_ascii_art
  puts  " #{"(@)" * @guesses_remaining}"
  puts "    ,\\,\\,|,/,/,
       _\\\|/_
      |_____|
       |   |
       |___|"
  end



  def generate_random_word
    return "hello"
    # return %w[foo bar baz].sample
  end

end



test_game = Game.new

test_game.print_directions

until test_game.game_over?
  test_game.get_input
end
