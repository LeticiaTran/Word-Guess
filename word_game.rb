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
    @secret_word = generate_random_word.split("")
    puts @secret_word.inspect
    @right_guesses = ""#"_" * @secret_word.length#Array.new(@secret_word.length, "_"),
    @wrong_guesses = []

    # @quessed_secret_word = ""
    # @
    # setup_game
  end

  def get_input
    print "Please enter a letter to guess > "
    user_input = gets.chomp.strip
    if @secret_word.include?(user_input)
      if !@right_guesses.include?(user_input)
        @right_guesses = "#{@right_guesses}#{user_input}"

      else
        puts "You've already guessed #{user_input}."
      end
    else
      @wrong_guesses << user_input
      # TODO: update hangman thing
    end
  end

  def print_current_guessed_letters
    # @secret_word.each { |index| if @secret_word[index] }

    puts @secret_word.join.gsub(/[^"#{@right_guesses}"]/,"_")
    # puts @secret_word.to_s.gsub(/[^"#{@secret_word.to_s}"]/,"_")
  end

  # Prints game directions.
  def print_directions
    # TODO: complete
  end

private



  def generate_random_word
    return "hello"
    # return %w[foo bar baz].sample
  end

end





test_game = Game.new

test_game.get_input
puts
test_game.print_current_guessed_letters
