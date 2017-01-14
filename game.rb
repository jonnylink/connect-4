require_relative "lib/board"
require_relative "lib/board_space"
require_relative "lib/move"
require_relative "lib/player"

# GET THE PLAYER NAMES
#----get player one-----#
player_name = ''
while player_name.empty?
  puts "Player 1, what is your name?" if player_name == ''
  player_name = gets.chomp.gsub(/\W+/, '')
end
puts "Thanks #{player_name}, you're: •\n\n"
player_1 = Player.new(player_name, "•")

#----get player two-----#
player_name = ''
while player_name.empty?
  puts "Player 2, what is your name?" if player_name == ''
  player_name = gets.chomp.gsub(/\W+/, '')
  if player_name == player_1.name
    puts "\nSorry, that name was already used."
    player_name = ''
  end
end
puts "Thanks #{player_name}, you're: ✖\n\n"
player_2 = Player.new(player_name, "✖")

# START THE GAME
play_again = 'y'
while play_again == 'y'
  the_board = Board.new
  puts "Let's get started!\n\n"
  puts the_board.print_board

  # CONTINUE UNTIL SOMEONE WINS
  game_over = false
  while !game_over
    valid_move = false
    next_player = (the_board.last_player == player_1) ? player_2 : player_1
    while valid_move == false
      puts "\n\nIt's your turn, #{next_player.name} (#{next_player.symbol}). Choose a column."
      the_move = the_move = Move.new(the_board, next_player, gets.chomp.upcase)
      valid_move = the_move.legal?
      puts "Sorry, #{the_move.column} isn't a valid move." if valid_move == false
    end
    the_move.make_move
    puts "\n"+ the_board.print_board
    game_over = true if the_move.winner? || the_move.draw?
  end

  # DECLARE WINNER
  if the_move.winner?
    puts "\nthe winner is #{the_move.player.name}!"
    the_board.last_player.wins += 1
    (the_board.last_player == player_1) ? player_2.losses += 1 : player_1.losses += 1
  else
    puts "the game is a draw!"
  end

  # PLAY AGAIN CHECK
  puts "Play again? (Y/N)"
  play_again = gets.chomp.downcase
  while play_again != 'n' && play_again != 'y'
    puts "\n\nPlay again? (Y/N)"
    play_again = gets.chomp.downcase
  end
end

# DISPLAY THE RESULTS
puts "\n\n#{player_1.name} won #{player_1.wins} times"
puts "#{player_2.name} won #{player_2.wins} times"

# FINISH THE GAME
puts "\n\nThanks for playing!"
