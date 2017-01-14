require "spec_helper"

describe Board do
  let (:test_board) {Board.new()}

  it "is intialized as a board with ten columns and ten rows" do
    expect(test_board.rows.size).to eq(10)
  end

  it "is intialized as a board with eight columns and eight rows" do
    expect(Board.new(8).rows.size).to eq(8)
  end

  it "prints out the board" do
    print_out =
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    " A B C D E F G H I J "
    expect(test_board.print_board).to eq(print_out)
  end

  it "prints out the board with a piece on it" do
    print_out =
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|              ◯    |\n" +
    " A B C D E F G H I J "
    the_player = Player.new("Jon", "◯")
    one_move = Move.new(test_board, the_player, "H").make_move
    expect(test_board.print_board).to eq(print_out)
  end

  it "returns the last player to make a move" do
    the_player = Player.new("Jon", "◯")
    one_move = Move.new(test_board, the_player, "H") .make_move
    expect(test_board.last_player).to eq(the_player)
  end
end
