class Move
  attr_reader :board, :player, :column, :column_as_index, :move_row

  def initialize(board, player, column)
    @board, @player, @column = board, player, column
  end

  def make_move
    if legal? && (@move_row = open_row) != false
      @board.rows[move_row][(column.ord - 65)].set_player(@player)
      @board.last_player = @player
      true
    else
      false
    end
  end

  def legal?
    if @column.length > 1
      false
    elsif @column.gsub(/[^a-zA-Z]+/, '').empty?
      false
    elsif @board.rows.size < (column.ord - 65)+1
      false
    elsif @board.rows[0][(column.ord - 65)].occupied?
      false
    else
      true
    end
  end

  def open_row
    @board.rows.to_enum.with_index.reverse_each do |row, index|
      return index if !row[(column.ord - 65)].occupied?
    end
    false
  end

  def winner?
    vertical_win? || horizontal_win? || diagonal_win?
  end

  def vertical_win?
    times_in_a_row = 0
    @board.rows.each do |row|
      if row[(column.ord - 65)].player == @player
        times_in_a_row += 1
      else
        times_in_a_row = 0
      end
      return true if times_in_a_row == 4
    end
    false
  end

  def horizontal_win?
    times_in_a_row = 0
    @board.rows[@move_row].each do |space|
      if space.player == @player
        times_in_a_row += 1
      else
        times_in_a_row = 0
      end
      return true if times_in_a_row == 4
    end
    false
  end

  def diagonal_win?
    diagonal = []
    #down_right
    diagonal[0] = [[@move_row+1, (@column.ord - 65)+1], [@move_row+2, (@column.ord - 65)+2], [@move_row+3, (@column.ord - 65)+3]]
    #up_right
    diagonal[1] = [[@move_row-1, (@column.ord - 65)+1], [@move_row-2, (@column.ord - 65)+2], [@move_row-3, (@column.ord - 65)+3]]
    #up_left
    diagonal[2] = [[@move_row-1, (@column.ord - 65)-1], [@move_row-2, (@column.ord - 65)-2], [@move_row-3, (@column.ord - 65)-3]]
     #down_left
    diagonal[3] = [[@move_row+1, (@column.ord - 65)-1], [@move_row+2, (@column.ord - 65)-2], [@move_row+3, (@column.ord - 65)-3]]
    diagonal.each do |line|
      times_in_a_row = 1
      line.each do |point|
        if !@board.rows[point[0]].nil? && !@board.rows[point[0]][point[1]].nil? && @board.rows[point[0]][point[1]].player == @player
          times_in_a_row += 1
        else
          times_in_a_row = 1
        end
        return true if times_in_a_row == 4
      end
    end
    false
  end

  def draw?
    is_a_draw = true
    @board.rows[0].each do |space|
      is_a_draw = false if !space.occupied?
    end
    is_a_draw
  end

end
