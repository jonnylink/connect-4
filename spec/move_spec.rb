require "spec_helper"

describe Move do
  let (:the_board) {Board.new()}
  let (:the_player) {Player.new("Jon", "X")}
  let (:first_move) {Move.new(the_board, the_player, "J")}

  it "returns the column specified" do
    expect(first_move.column).to eq("J")
  end

  it "returns false if column is a number" do
    bad_move = Move.new(the_board, the_player, "1221")
    expect(bad_move).to_not be_legal
  end

  it "returns false if column isn't on the board" do
    bad_move = Move.new(the_board, the_player, "K")
    expect(bad_move).to_not be_legal
  end

  it "returns false if column is full" do
    10.times {first_move.make_move}
    bad_move = Move.new(the_board, the_player, "J")
    expect(bad_move).to_not be_legal
  end

  it "returns the first open row" do
    expect(first_move.open_row).to eq(9)
  end

  it "puts the player in the first open space" do
    expect(first_move.make_move).to eq(true)
  end

  it "returns false if there is no open row" do
    10.times {first_move.make_move}
    expect(first_move.make_move).to eq(false)
  end

  it "declares a winner if a player drops a piece that makes a vertical line of 4 of their pieces" do
    4.times {first_move.make_move}
    expect(first_move).to be_winner
  end

  it "does not declare a winner if a player drops a piece that makes a vertical line of less than 4 of their pieces" do
    3.times {first_move.make_move}
    expect(first_move).to_not be_winner
  end

  it "declares a winner if a player drops a piece that makes a horizontal line of 4 of their pieces" do
    3.times do |looped|
      Move.new(the_board, the_player, (looped+65).chr).make_move
    end
    win_move = Move.new(the_board, the_player, "D")
    win_move.make_move
    expect(win_move).to be_winner
  end

  it "does not declare a winner if a player drops a piece that makes a horizontal line of 3 of their pieces" do
    2.times do |looped|
      Move.new(the_board, the_player, (looped+65).chr).make_move
    end
    just_a_move = Move.new(the_board, the_player, "C")
    just_a_move.make_move
    expect(just_a_move).to_not be_winner
  end

  it "declares a winner if a player drops a piece that makes a diagonal line of 4 of their pieces" do
    the_enemy = Player.new("Don", "Q")
    #set the first column
    3.times { Move.new(the_board, the_enemy, "A").make_move }
    Move.new(the_board, the_player, "A").make_move
    #set the second column
    2.times { Move.new(the_board, the_enemy, "B").make_move }
    Move.new(the_board, the_player, "B").make_move
    #set the third column
    Move.new(the_board, the_enemy, "C").make_move
    Move.new(the_board, the_player, "C").make_move
    #make the winning move!
    win_move = Move.new(the_board, the_player, "D")
    win_move.make_move
    expect(win_move).to be_diagonal_win
  end

  it "declares a draw when the board is full." do
    looped = 0
    99.times do
      Move.new(the_board, the_player, (looped+65).chr).make_move
      looped == 9 ? looped = 0 : looped += 1
    end
    last_move = Move.new(the_board, the_player, "J")
    last_move.make_move
    expect(last_move).to be_draw
  end

  it "does not declare a draw when the board is not full." do
    first_move.make_move
    expect(first_move).to_not be_draw
  end

end
