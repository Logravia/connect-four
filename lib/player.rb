# frozen_string_literal: true

# lib/player.rb

require 'pry-byebug'

# Allows player to interact with the game by handling column choice of the player
# And letting the game handle any special input players might've put in
# E.g. q for quit, h for help
class Player
  LEGIT_CHOICE = /^[1-8]$/.freeze
  private_constant :LEGIT_CHOICE

  def initialize(game)
    @game = game
    @token = nil
    @wins = 0
  end

  def choose_column
    loop do
      input = gets.chomp
      break if @game.special_input?(input)

      column = sanitize_column_choice(input)
      return column unless column.nil?

      puts 'MSG'
    end
  end

  private

  def sanitize_column_choice(choice)
    choice = choice.match(LEGIT_CHOICE)
    choice.nil? ? nil : choice.to_s.to_i
  end
end
