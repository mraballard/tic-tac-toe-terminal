require_relative 'ttt'
system "clear"
puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp
while player != 'X' && player != 'O'
  puts "Please choose 'X' or 'O'."
  player = gets.chomp
end
game = TicTacToe.new(player)

# If player chooses 'O', computer moves first
if player == 'O'
  game.computerMove
end

system "clear"

while !game.gameover
  if game.checkError
    puts "Error: " + game.checkError
    game.clearError
  end
  game.getInput
  system "clear"
end

puts game.winner
