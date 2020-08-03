require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0, 10].join.upcase.chars
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].chars
    # @token = params[:authenticity_token]
    # The word can’t be built out of the original grid
    @sentence =
      if in_grid?(word, letters) && english_word?(word)
        "Congrats! #{word.upcase} is a valid english word!"
      elsif in_grid?(word, letters)
        "Sorry but #{word.upcase} is not a valid english word."
      else
        "Sorry but #{word.upcase} cannot built out of #{letters.join(', ')}"
      end
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
  end
  private

  def in_grid?(word, letters)
    word.chars.all? { |letter| letters.count(letter) >= word.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    result = JSON.parse(response)
    result['found']
  end
end

 # params[:authenticity_token]
