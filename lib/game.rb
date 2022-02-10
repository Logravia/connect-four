# lib/game.rb
# frozen_string_literal: true

# Handles the main gameloop, object interactation for the game to happen
# E.g. Player input token gets dropped down the Board and displayed by Display
class Game
  def initialize
    @round = 0
  end

  def special_input?(input); end


end
