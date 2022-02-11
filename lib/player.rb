# frozen_string_literal: true

# lib/player.rb

require 'pry-byebug'

# Allows player to interact with the game by handling column choice of the player
# And letting the game handle any special input players might've put in
# E.g. q for quit, h for help

class Player
  LEGIT_COLUMNS = /^[1-8]$/.freeze
  LEGIT_TOKENS= /^.$/.freeze
  SPECIAL_INPUT = /^[qh]!$/.freeze

  private_constant :LEGIT_COLUMNS , :LEGIT_TOKENS, :SPECIAL_INPUT
  attr_reader :token

  def initialize(game)
    @game = game
    @token = nil
    @wins = 0
  end

  def choose_column
    return get_value(LEGIT_COLUMNS, 'Wrong column').to_i - 1
  end

  def choose_token
    @token = get_value(LEGIT_TOKENS, 'Wrong token')
  end

  private

  def get_value(valid_value, error_msg)
    value = nil
    loop do
      input = gets.chomp

      if special_input?(input)
        @game.handle_special_input(input)
        return
      end

      value = sanitize_input(input, valid_value)
      break unless value.nil?

      puts error_msg
    end
    value
  end

  def sanitize_input(choice, pattern)
    choice = choice.match(pattern)
    choice.nil? ? nil : choice.to_s
  end

  def special_input?(input)
    input.match(SPECIAL_INPUT) ? true : false
  end

end
