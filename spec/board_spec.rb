# board_spec.rb

require_relative '../lib/board.rb'

describe Board do
  subject(:board){described_class.new()}

  describe '#drop_down' do
    it "adds one token on the board" do
      token = 'X'
      column = 1
      board.drop_token(column, token)
      # token_grid is a 2D array of 7*6 containing nil in all the empty spaces
      token_grid = board.token_grid.flatten.compact
      expect(token_grid).to contain_exactly(token)
    end

    it "adds two different tokens on the board with different specified columns" do
      token_1, token_2 = 'X', 'Y'
      col_1, col_2 = 1, 2
      board.drop_token(col_1, token_1)
      board.drop_token(col_2, token_2)
      token_grid = board.token_grid.flatten.compact
      expect(token_grid).to contain_exactly(token_1, token_2)
    end

    it "adds two different tokens with the same specified column" do
      token_1, token_2 = 'X', 'Y'
      col = 1
      board.drop_token(col, token_1)
      board.drop_token(col, token_2)
      token_grid = board.token_grid.flatten.compact
      expect(token_grid).to contain_exactly(token_1, token_2)
    end

    it "drops two tokens on top of each other" do
      tokens = %w[A B]
      col = 1
      tokens.each { |token| board.drop_token(col, token) }
      column = board.token_grid.transpose[col]
      expect(column).to eq([nil,nil,nil,nil,'B','A'])
    end

    it "fills up the whole column as though it was a stack" do
      tokens = %w[A B C D E F]
      col = 1
      tokens.each { |token| board.drop_token(col, token) }
      column = board.token_grid.transpose[col]
      expect(column).to eq(['F','E','D','C','B','A'])
    end

    it "does not break a full column when trying to drop extra token" do
      tokens = %w[A B C D E F]
      extra_tokens = %w[G H I J K L M N O P R S T U V Z]
      col = 1
      tokens.each { |token| board.drop_token(col, token) }

      extra_tokens.each { |token| board.drop_token(col, token) }

      column = board.token_grid.transpose[col]
      expect(column).to eq(['F','E','D','C','B','A'])
    end

    it "can drop token in each column" do
      tokens = %w[A B C D E F G]
      row = board.token_grid.first
      row.each_with_index { |_e, column| board.drop_token(column, tokens[column]) }
      last_row = board.token_grid.last
      expect(last_row).to eq(tokens)
    end

    it "does not allow to drop a token out of bounds" do
      token = 'X'
      out_of_bounds_columns = [-1,8,9,-20,100,5000]

      out_of_bounds_columns.each do |column|
        board.drop_token(column, token)
      end

      token_grid = board.token_grid.flatten.compact
      expect(token_grid).to be_empty
    end
  end

  describe '#victory?' do

    context "handles horizontal victory" do

      it "returns false when max same 3 consecutive tokens horizontally" do
        board = described_class.new([
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          ["T",nil,nil,nil,nil,nil,nil],
          ["T","T","T",nil,nil,nil,"T"],
          ["X","X","X","T","X","T","T"],
          ["T","T","T","X","X","T","T"],
                                    ]
        )
        expect(board).not_to be_victory
      end

      it "returns true 4 when consecutive tokens at bottom" do
        board = described_class.new([
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          ["T","T","T","T","X","T","T"],
                                    ]
        )
        expect(board).to be_victory
      end

      it "returns true when 4 consecutive token in middle" do
        board = described_class.new([
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,"T","T","T","T",nil],
          [nil,nil,"X","T","X","T",nil],
          [nil,nil,"T","X","T","X",nil],
          ["T","T","T","X","X","X","T"],
                                    ]
        )
        expect(board).to be_victory
      end

    end

    context "handles vertical victory" do
      it "returns false when max same 3 consecutive tokens vertically" do
        board = described_class.new([
          [nil,nil,"X",nil,"X",nil,nil],
          ["T",nil,"T",nil,"X",nil,nil],
          ["T",nil,"T",nil,"T",nil,"X"],
          ["T","T","T",nil,"X",nil,"T"],
          ["X","X","X","T","X","T","T"],
          ["T","T","T","X","X","T","T"],
                                    ]
        )
        expect(board).not_to be_victory
      end

      it "returns true when 4 consecutive tokens vertically I" do
        board = described_class.new([
          ["T",nil,"X",nil,"X",nil,nil],
          ["T",nil,"T",nil,"X",nil,nil],
          ["T",nil,"T",nil,"T",nil,"X"],
          ["T","T","T",nil,"X",nil,"T"],
          ["X","X","X","T","X","T","T"],
          ["T","T","T","X","X","T","T"],
                                    ]
        )
        expect(board).to be_victory
      end

      it "returns true when 4 consecutive tokens vertically II" do
        board = described_class.new([
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,"T",nil],
          [nil,nil,nil,nil,nil,"T",nil],
          ["X","X","X","T","X","T","T"],
          ["T","T","T","X","X","T","T"],
                                    ]
        )
        expect(board).to be_victory
      end
    end

  end

end
