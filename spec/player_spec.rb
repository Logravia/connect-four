# frozen_string_literal: true

# player_spec.rb

require_relative '../lib/player'
require_relative '../lib/game'

describe Player do
  describe '#choose_column' do
    subject(:player) { described_class.new(game_dummy) }
    let(:game_dummy) { instance_double(Game) }

    context 'handles valid and invalid input' do
      before do
        allow(game_dummy).to receive(:special_input?).and_return(nil)
      end

      it 'returns the chosen column as single positive digit' do
        allow(player).to receive(:gets).and_return("1\n")
        chosen_column = 1
        expect(player.choose_column).to eq(chosen_column)
      end

      it 'puts message when bad input, stops get loop after good message' do
        bad_input = "1asfsaefg\n"
        good_input = "5\n"
        allow(player).to receive(:gets).and_return(bad_input, bad_input, good_input)
        expect(player).to receive(:puts).twice
        player.choose_column
      end

      it 'loop is ended immediately with first good input' do
        bad_input = "1asfsaefg\n"
        good_input = "5\n"
        allow(player).to receive(:gets).and_return(good_input, bad_input, bad_input, bad_input)
        expect(player).not_to receive(:puts)
        player.choose_column
      end
    end

    context 'handles special input' do
      it 'ends its loop after special input and lets game handle it' do
        special_input = "h\n"
        allow(player).to receive(:gets).and_return(special_input)
        allow(game_dummy).to receive(:special_input?).with(special_input).and_return(true)
        expect(player).not_to receive(:puts)
      end
    end
  end
end
