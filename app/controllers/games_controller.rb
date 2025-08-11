require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @messages = ["Given letters: #{params[:letters].split('').join('-')}", "word: #{params[:word]}"]
    english_hash = JSON.parse(URI.open("https://dictionary.lewagon.com/#{params[:word].upcase}").read)
    word_valid = word_valid?(params[:word].upcase, params[:letters].upcase);
    if english_hash['found'] && word_valid
      score_counter(params[:word])
      @messages << 'Congratulation!'
    else
      @messages << 'Word not found' unless english_hash['found']
      @messages << 'Word not matches given letters' unless word_valid
    end
    @messages << "You have #{session[:score]} points"
  end

  private

  def word_valid?(word, letters)
    return_val = true
    word.chars.each do |char|
      if letters.include?(char)
        letters.delete(char)
      else
        return_val = false
      end
    end
    return_val
  end

  def score_counter(word)
    if session[:score]
      session[:score] += word.size
    else
      session[:score] = 0
    end
  end
end
