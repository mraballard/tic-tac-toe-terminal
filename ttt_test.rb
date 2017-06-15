require 'minitest/autorun'
require 'minitest/pride'
require_relative 'ttt'

class TicTacToeTest < Minitest::Test
  def test_start_game
    #skip
    game = TicTacToe.new
    assert_equal false, game.endGame?
  end
end
