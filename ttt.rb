class TicTacToe
  def initialize
    @board = {
      '1': {
        'a': ' ',
        'b': ' ',
        'c': ' ',
      },
      '2': {
        'a': ' ',
        'b': ' ',
        'c': ' ',
      }
      '3': {
        'a': ' ',
        'b': ' ',
        'c': ' ',
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
    @header =  `          A   B   C`
    @rowDiv =  `        +---+---+---+`
  end

  def printBoard
    puts @header
    @board.each { |row|
      puts @rowDiv
      puts `    #{row}   | #{row.a} | #{row.b} | #{row.c}`
    }
    puts @rowDiv
  end

  def checkWin?
    @winners.each { |line|
      if line == @Owin
        endGame?('O')
      elsif line == @Xwin
        endGame?('X')
      end
    }
  end

  def endGame?(player)
    puts case player
    when 'X'
      "X has won"
    when 'O'
      "O has won"
    else
      nextturn
    end
  end

end
