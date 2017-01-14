require "spec_helper"

describe BoardSpace do
  let (:board_space) {BoardSpace.new()}
  let (:jon_player) {Player.new('Jon','X')}

  it "is occupied if a player has played there" do
    board_space.set_player(jon_player)
    expect(board_space).to be_occupied
  end

  it "is not occupied if no players have played the space" do
    expect(board_space).to_not be_occupied
  end

  it "has a player assigned once played" do
    board_space.set_player(jon_player)
    expect(board_space.player).to eq(jon_player)
  end

  it "cannot be occupied twice" do
    board_space.set_player(jon_player)
    expect(board_space.set_player(jon_player)).to eq(false)
  end

end
