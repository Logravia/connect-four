# lib/board.rb

require 'pry-byebug'

class Board

  WIDTH = 7
  HEIGHT = 6
  CONSEC_TOKENS_REQ = 4

  private_constant :WIDTH, :HEIGHT
  attr_reader :token_grid

  def initialize(token_grid = Array.new(HEIGHT) {Array.new(WIDTH)})
    @token_grid = token_grid
  end

  def drop_token(column, token)
    return false if not column.between?(0,WIDTH-1)
     if not @token_grid.first[column].nil?
       # Can't drop, column is filled up
       false
     else
       # Token can't drop down without something pulling on it
       pull_token_down(column, token)
       true
     end
  end

  def victory?
    horizontal_win?
  end

  def horizontal_win?
    @token_grid.each do |row|
      return true if required_consecutive_tokens(row)
    end
    false
  end

  def required_consecutive_tokens(arr)
    arr.each_cons(CONSEC_TOKENS_REQ) do |arr_slice|
      if arr_slice.all? arr_slice.first and arr_slice.none? nil
        return true
      end
    end
    false
  end

  private
  def pull_token_down(column, token)
    if @token_grid.last[column].nil?
      @token_grid.last[column] = token
      return
    end

    @token_grid.each_with_index do |row, row_depth|
      # When find a row with a token in it
      if not row[column].nil?
        # Add token above it
        @token_grid[row_depth-1][column] = token
        return
      end
    end

  end
end
