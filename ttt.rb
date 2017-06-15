class TicTacToe
  def initialize
    @board = {
      "1" => {
        "a" => ' ',
        "b" => ' ',
        "c" => ' ',
      },
      "2" => {
        "a" => ' ',
        "b" => ' ',
        "c" => ' ',
      },
      "3" => {
        "a" => ' ',
        "b" => ' ',
        "c" => ' ',
      }
    }
    @winners = [
      # Horizontal Winners
      ['a1', 'b1', 'c1'],
      ['a2', 'b2', 'c2'],
      ['a3', 'b3', 'c3'],
      # Vertical Winners
      ['a1', 'a2', 'a3'],
      ['b1', 'b2', 'b3'],
      ['c1', 'c2', 'c3'],
      # Diagonal Winners
      ['a1', 'b2', 'c3'],
      ['c1', 'b2', 'a3']
    ]
    @Owin = ['O', 'O', 'O']
    @Xwin = ['X', 'X', 'X']
    @header =  '          A   B   C'
    @rowDiv =  '        +---+---+---+'
  end

  def printBoard
    puts @header
    @board.each { |row, value|
      puts @rowDiv
      puts "    #{row}   | #{value["a"]} | #{value["b"]} | #{value["c"]} |"
    }
    puts @rowDiv
  end

  def newMove(player, move)
    @board[move.chars.last][move.chars.first.downcase] = player
  end

  def endGame?
    @winners.each { |line|
      if line == @Owin
        return 'O'
      elsif line == @Xwin
        return 'X'
      else
        return false
      end
    }
  end

end
