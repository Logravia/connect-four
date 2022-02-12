# game_spec.rb
require_relative '../lib/game.rb'

describe Game do
  subject(:game){described_class.new}
  let(:players){game.players}
  describe "#set_player_tokens" do

    before do
      allow(players[0]).to receive(:token).and_return('X')
      allow(players[1]).to receive(:token).and_return('Y')
      allow_any_instance_of(Player).to receive(:choose_token)
    end

    it "calls players to set their tokens" do
      expect(players[0]).to receive(:choose_token).once
      expect(players[1]).to receive(:choose_token).once
      game.set_player_tokens
    end

    it 'asks p1 to set a new token if same as p0' do
      allow(players[1]).to receive(:token).and_return('X','X','X','Y')
      expect(players[1]).to receive(:choose_token).twice
      game.set_player_tokens
    end
  end

  describe "#play" do
    before do
      allow(game.players[0]).to receive(:choose_column)
      allow(game.players[1]).to receive(:choose_column)
      allow(game.board).to receive(:drop_token).and_return(true)
      allow(game).to receive(:set_player_tokens)
    end

    it "ends game after tie" do
      allow(game.board).to receive(:tie?).and_return(true)

      expect(Msg).to receive(:tie)
      expect(game).to receive(:another_game?)
      game.play
    end

    it "ends game after victory" do
      allow(game.board).to receive(:victory?).and_return(false, false, false, true)

      expect(Msg).to receive(:victory)
      expect(game).to receive(:another_game?)
      game.play
    end


    it "calls for tokens to be dropped until player wins" do
      allow(game.board).to receive(:victory?).and_return(false, false, false, true)
      expect(game.board).to receive(:drop_token).exactly(4).times
      game.play
    end

    it "calls for tokens to be dropped until tie" do
      allow(game.board).to receive(:tie?).and_return(false, false, false, true)
      expect(game.board).to receive(:drop_token).exactly(4).times
      game.play
    end


  end
end
