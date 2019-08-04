
require 'open-uri'
class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.shuffle.take(10)
  end

  def score
    # binding.pry
    # raise
    # We want to handle three scenarios:
    @user_choice = params[:user_letters]
    @grid = params[:grid]
    @score = 0
    if included_in_grid?(@user_choice,@grid)
      ruby_hash = api_call(@user_choice)

      # raise
      if ruby_hash["found"] == true
    # The word is valid according to the grid and is an English word
        @message = "Congratulations, #{@user_choice} is a valid english word"
        @score = @user_choice.length
      else
    # The word is valid according to the grid, but is not a valid English word
        @message = "Sorry but #{@user_choice} does not seem to be a valid English word"
      end
    else
    # The word can't be built out of the original grid
      @message = "The word can't be built out of the original grid"
    end

    if session[:score]
     session[:score] += @score
    else
      session[:score] = @score
    end
  end

  def included_in_grid?(word, grid)
    grid_array = JSON.parse(grid)
    array = word.upcase.split("").select { |letter| grid_array.include?(letter) }
    #   result = nil
    #   array.each do |letter|
    #     result = array.count(letter) <= grid_array.count(letter)
    #     break if result == false
    #   end
    #   result

    array.all? { |letter| array.count(letter) <= grid_array.count(letter) }

  end

  def api_call(word)
   json_file = open("https://wagon-dictionary.herokuapp.com/#{word}").read
   ruby_hash = JSON.parse(json_file)
  end

end
