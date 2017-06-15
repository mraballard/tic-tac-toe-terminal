require_relative 'ttt'

puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp
if player == 'X'
  comp = 'O'
else
  comp = 'X'
end

game = TicTacToe.new(player)

game.printBoard

while game.finishGame == false
  puts "Where do you want to move?"
  move = gets.chomp

  game.playerMove(move)

  if move == 'Q'
    break
  end
end
