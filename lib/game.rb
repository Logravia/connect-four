# lib/game.rb
# frozen_string_literal: true
require 'pry-byebug'
require_relative 'player'
require_relative 'display'
require_relative 'board'
require_relative 'messages'

# Handles the main gameloop, object interactation for the game to happen
# E.g. Player input token gets dropped down the Board and displayed by Display
class Game
  extend Msg

  attr_reader :round, :board, :players

  def initialize(board = Board.new)
    @round = 0
    @board = board
    @state = @board.token_grid
    @players = [Player.new(self), Player.new(self)]
    @display = Display.new
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

  def play
    set_player_tokens
    loop do
      @display.game(@board.token_grid, "#{Msg.choose_column} #{players[0].token}")
      drop_token

      (puts Msg.victory; break) if @board.victory?
      (puts  9Msg.tie; break) if @board.tie?

      @players = @players.rotate
    end
    another_game?
  end


  def drop_token
    successful_drop = false
    until successful_drop
      successful_drop = @board.drop_token(@players[0].choose_column, @players[0].token)
      @display.game(@board.token_grid, Msg.column_full)
    end
  end

  def another_game?

  end

  def handle_special_input(input)

  end

end
