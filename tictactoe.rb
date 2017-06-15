require_relative 'ttt'

game = TicTacToe.new
gameover = false

puts "Welcome to Tic Tac Toe in Ruby \nWhich player do you want to be? X or O?"

player = gets.chomp

game.printBoard
# while gameover == false
#
# end
