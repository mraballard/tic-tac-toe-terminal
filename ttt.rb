class TicTacToe
  def initialize(player)
    @player = player
    if player == 'X'
      @comp = 'O'
    else
      @comp = 'X'
    end
    # Board to record player moves
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
    # Array to track available spaces for next moves.
    @possibleMoves = ['a1', 'b1', 'c1', 'a2', 'b2', 'c2', 'a3', 'b3', 'c3']
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
    # Define winning combinations
    @oWin = ['O', 'O', 'O']
    @xWin = ['X', 'X', 'X']
    # Board graphics
    @header =  '          A   B   C'
    @rowDiv =  '        +---+---+---+'

    @gameover = false
  end

  def printBoard
    puts @header
    @board.each { |row, value|
      puts @rowDiv
      puts "    #{row}   | #{value["a"]} | #{value["b"]} | #{value["c"]} |"
    }
    puts @rowDiv
  end

  def playerMove(move)
    @possibleMoves.delete(move)
    # Reverse order of move from B2 to 2B to match @board object
    move = move.chars.last + move.chars.first.downcase
    @board[move.chars.first][move.chars.last] = @player
    if @possibleMoves.length == 0
      draw
    elsif winner? == @player
      puts "#{@player} has won!"
      @gameover = true
    else
      computerMove
    end
  end

  def computerMove
    random = rand(@possibleMoves.length)
    move = @possibleMoves[random]
    @possibleMoves.delete(move)
    @board[move.chars.last][move.chars.first.downcase] = @comp
    if winner? == @comp
      puts "#{@comp} has won!"
      @gameover = true
    end
    printBoard
  end

  def draw
    @gameover = true
    puts "The game is a tie. Wah wahhh... :("
    finishGame
  end

  def winner?
    @winners.each { |line|
      check = []
      line.each {|el|
        check.push(@board[el.chars.last][el.chars.first])
      }
      if check == @oWin
        return 'O'
      elsif check == @xWin
        return 'X'
      end
    }
  end

  def finishGame
    return @gameover
  end

end
