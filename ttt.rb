require_relative 'ttt'
system "clear"
puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp
while player.downcase != 'x' && player != 'o'
  puts "Please choose 'X' or 'O'."
  player = gets.chomp.downcase
end
game = TicTacToe.new(player.upcase, 3)

# If player chooses 'O', computer moves first
if player == 'o'
  game.computerMove
end


loop do
  if game.checkError
    puts "Error: " + game.checkError
    game.clearError
  end
  game.getInput
end
