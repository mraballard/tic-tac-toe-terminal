require_relative 'ttt'

game = TicTacToe.new
gameover = false

puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp
if player == 'X'
  comp = 'O'
else
  comp = 'X'
end

game.printBoard

while gameover == false
  puts "Where do you want to move?"
  move = gets.chomp

  game.newMove(player, move)

  game.printBoard



  if move == 'Q'
    break
  end
end
