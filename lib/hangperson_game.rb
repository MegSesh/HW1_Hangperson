class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(new_word)
    @word, @guesses, @wrong_guesses = new_word, '', ''
  end

  def guess(s)
    #processes a guess and modifies the instance vars wrong_guesses and guesses

    #(1) invalid
    #throws ArgumentError when nil or empty
    if s.nil? == true
      raise ArgumentError.new('The input is nil or an empty string')
    end
    if s.empty? == true
      raise ArgumentError.new('The input is nil')
    end

    #throws Argument Error when not a letter
    s.downcase!
    if /^[A-Za-z]/.match(s) == nil
      raise ArgumentError.new('The input is not a letter')
    end

    #(2) correct guess
    #if letter/guess "s" is in new_word, then guesses = s and wrong_guesses = ''
    #returns true
    if word.include?(s)

      #CORRECT VERSION
      if @guesses.include?(s)
        return false
      else
        @guesses.concat(s)
        return true
      end

    end

    #(3) incorrect guess
    #if letter/guess "s" is NOT in new_word, then guess = '' and wrong_guess = s
    #returns true
    if word.include?(s) == false
      if@wrong_guesses.include?(s)
        return false
      else
        @wrong_guesses.concat(s)
        return true
      end
    end

    #(4) same letter repeatedly

  end

  def check_win_or_lose()
    #returns one of the symbols :win, :lose, or :play depending on current game state

    #when all letters are guessed, return :win

    if @guesses.length == word.chars.to_a.uniq.length
      return :win
    end

    #after 7 incorrect guesses, return :lose
    #if word.count(s[1], s[2], s[3], s[4], etc) >= (s.length - 7)
    if @wrong_guesses.length >= 7
      return :lose
    end

    #if neither win nor lose, return :play
    return :play
  end

  def word_with_guesses()
    #substitutes correct guesses made so far into the word
    # if the letter is both in guesses and the word, then display it
    # if not, put a '-' symbol
    # OR replace that letter in the word (that isn't in both) with '-'

    #intial string of '-'
    # but you'd have to create one of length of the word

    #copy of the word
    word_copy = word.dup

    word_copy.each_char do |i|
      if @guesses.include?(i) == false
        #puts i #--> this works
        word_copy.sub!(i, '-') #this does not work
        #puts word_copy
      end
    end

    #return intial string or return copied word
    #return word_copy

  end



end
