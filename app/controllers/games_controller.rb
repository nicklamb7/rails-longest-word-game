require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    # 1. Check to see if the letters of the user match the randomly generated letters
    @user_answer = params[:answer]
    @random_letters = params[:random_letters]
    @included = included?
    # 2. Check if the users answer is an English word
    @english_word = english_word?
    # 3. Calculate score based on time and length
    # if @included && @english_word
  end

  private

  def included?
    @user_answer.chars.all? { |letter| @user_answer.count(letter) <= @random_letters.count(letter) }
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@user_answer}"
    response = URI.open(url).read
    result = JSON.parse(response)
    result["found"]
  end
end
