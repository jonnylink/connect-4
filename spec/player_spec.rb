require "spec_helper"

describe Move do
  let (:the_player) {Player.new("Jon", "X")}

  it "stores the payer name" do
    expect(the_player.name).to eq("Jon")
  end

  it "stores the payer symbol" do
    expect(the_player.symbol).to eq("X")
  end

  it "stores the player wins"do
    the_player.wins = 3
    expect(the_player.wins).to eq(3)
  end

  it "stores the player losses"do
    the_player.wins = 1
    expect(the_player.wins).to eq(1)
  end

end
