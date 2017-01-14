require_relative "board_space"

class Board
  attr_reader :game_board
  attr_accessor :last_player

  def initialize (num_rows_cols=10)
    @game_board = []
    @last_player = ''
    num_rows_cols.times do
      row = []
      num_rows_cols.times do
        row << BoardSpace.new
      end
      @game_board << row
    end
  end

  def rows
    @game_board
  end

  def print_board
    print_out = ""
    bottom_line = " "
    @game_board.each_with_index do |row, index|
      print_out += "|"
      row.each { |space| print_out += space.get_symbol + " " }
      print_out = print_out.chomp(" ") + "|\n"
      bottom_line += (index+65).chr + " "
    end
    print_out += bottom_line
  end

end
