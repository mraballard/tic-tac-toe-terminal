###############################################
### Runs game of Tic Tac Toe
###
###############################################

require_relative 'tictactoe'

system "clear"
puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

# Player chooses X or O
player = gets.chomp.downcase
while player.downcase != 'x' && player != 'o'
  puts "Please choose 'X' or 'O'."
  player = gets.chomp.downcase
end
game = TicTacToe.new(player.upcase, 3)

# If player chooses 'O', computer moves first
if player == 'o'
  game.computerMove
end

# Main run loop, runs until game ends or user hit's 'Q'
loop do
  if game.checkError
    puts "Error: " + game.checkError
    game.clearError
  end
  game.getInput
end
