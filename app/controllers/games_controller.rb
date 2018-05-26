require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @user_word = params[:user_word]
    @letters = params[:letters]

    p english_word?(@user_word), has?(@user_word)

    if has?(@user_word) == false
      @answer = "You're using letters that were not given to you"
    elsif english_word?(@user_word) == false
      @answer = "That's not an English word"
    elsif english_word?(@user_word) && has?(@user_word)
      @answer = "Good one!"
    else
        @answer = "Youre simply wrong"
    end
  end


  private

  def english_word?(word)
    filepath = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary_api = open(filepath).read
    dictionary = JSON.parse(dictionary_api)
    return true if dictionary['found']
  end

  def has?(word)
     @letters = params[:letters].downcase.split(" ")
    p "this is the arraz:", @letters
    word.chars.all? do |character|
     @letters.include?(character)
    end
  end
end
