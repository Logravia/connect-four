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
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def tie?
    @token_grid.flatten.none? nil
  end

  private

  def horizontal_win?
    @token_grid.each do |row|
      return true if required_consecutive_tokens(row)
    end
    false
  end

  def vertical_win?
    @token_grid.transpose.each do |column|
      return true if required_consecutive_tokens(column)
    end
    false
  end

  def diagonal_win?

    l_diagonals.each do |diagonal|
      return true if required_consecutive_tokens(diagonal)
    end

    r_diagonals.each do |diagonal|
      return true if required_consecutive_tokens(diagonal)
    end

    false

  end

  def l_diagonals(token_grid = @token_grid)
    cur_col = 0
    cur_row = token_grid.size
    diagonals = []

    # Get all the diagonal lines going left to right from the left edge
    while cur_row > 0
     cur_row -= 1
     diagonals << get_diagonal_line(cur_col, cur_row, token_grid)
    end

    # Get all the diagonal lines going left to right from the top edge
    while cur_col < token_grid.size
     cur_col += 1
     diagonals << get_diagonal_line(cur_col, cur_row, token_grid)
    end

    diagonals
  end

  def r_diagonals
    l_diagonals(@token_grid.reverse)
  end

  def get_diagonal_line(cur_col, cur_row, matrix)
    diagonal = []
    while cur_row < matrix.length && cur_col < matrix[0].length
        diagonal << matrix[cur_row][cur_col]
        cur_row += 1
        cur_col += 1
    end
    diagonal
  end

  def required_consecutive_tokens(arr)
    arr.each_cons(CONSEC_TOKENS_REQ) do |arr_slice|
      if arr_slice.all? arr_slice.first and arr_slice.none? nil
        return true
      end
    end
    false
  end

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
