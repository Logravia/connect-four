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
        allow(game_dummy).to receive(:handle_special_input).and_return(nil)
      end

      it 'returns the chosen column as single positive digit reduced by one' do
        allow(player).to receive(:gets).and_return("1\n")
        chosen_column = 1
        expect(player.choose_column).to eq(chosen_column-1)
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
        allow(game_dummy).to receive(:handle_special_input).with(special_input).and_return(true)
        expect(player).not_to receive(:puts)
      end
    end

    describe '#choose_token' do
      let(:game_dummy) { instance_double(Game) }
      subject(:player) { described_class.new(game_dummy) }

      context "#handles valid input" do
        it "sets token" do
          token = 'X'
          allow(player).to receive(:gets).and_return(token)
          player.choose_token
          expect(player.token).to eq(token)
        end
      end
      context "#rejects invalid input with error message" do
        it "warns three times of invalid input" do
          valid_input = 'X'
          allow(player).to receive(:gets).and_return('asdas', 'as', 'vbsdv', valid_input, 'asb')
          expect(player).to receive(:puts).exactly(3).times
          player.choose_token
        end
        context "special input" do
          before do
            allow(game_dummy).to receive(:handle_special_input)
          end
          it "does not save invalid input as token" do
            invalid_input = 'QED'
            special_input = 'h!'

            allow(player).to receive(:gets).and_return(invalid_input, special_input)

            player.choose_token
            expect(player.token).to be_nil
          end

          it "asks game to handle special input" do
            special_input = 'h!'
            allow(player).to receive(:gets).and_return(special_input)
            expect(game_dummy).to receive(:handle_special_input).once
            player.choose_token
          end

          it "ends input loop on special input" do
            special_input = 'h!'
            allow(player).to receive(:gets).and_return(special_input)
            expect(player.choose_token).to be_nil
          end
        end

      end
    end
  end
end
