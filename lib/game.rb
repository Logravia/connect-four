# lib/game.rb
# frozen_string_literal: true

# Handles the main gameloop, object interactation for the game to happen
# E.g. Player input token gets dropped down the Board and displayed by Display
class Game
  def initialize
    @round = 0
  end

  def set_player_tokens

    @players.each_with_index do |player, num|
      @display.game(@board.token_grid, "Player #{num+1}, #{Msg.choose_token} ")
      player.choose_token
      @display.game(@state, "#{Msg.good_token}: #{player.token}")
      #sleep(2)
    end

    while @players[1].token == @players[0].token
      @display.game(@state, "#{Msg.same_token}: #{@players[1].token}")
      @players[1].choose_token
    end
  end



end
