class Player
  attr_reader :name, :symbol
  attr_accessor :wins, :losses

  def initialize (name, symbol)
    @name, @symbol = name, symbol
    @wins, @losses = 0, 0
  end

end
