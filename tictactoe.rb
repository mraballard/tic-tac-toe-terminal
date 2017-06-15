require_relative 'ttt'

puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp
game = TicTacToe.new(player)
if player == 'O'
  game.computerMove
end

while game.finishGame == false

  game.printBoard

  puts "Where do you want to move?"
  move = gets.chomp

  game.playerMove(move)

  if move == 'Q'
    break
  end
end
