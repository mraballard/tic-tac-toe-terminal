###############################################
### Game Logic for TicTacToe
### Builds board, possible moves, win / lose / draw logic
###############################################

class TicTacToe
  def initialize(player, size)
    @error = nil
    @player = player
    if player == 'X'
      @comp = 'O'
    else
      @comp = 'X'
    end
    # Board to record player moves
    @alphabet = ("a".."z").to_a
    @size = size
    @board = {}
    1.upto(@size) { |row|
      @board[row] = {}
      0.upto(@size - 1) { |column|
        @board[row][@alphabet[column]] = " "
      }
    }

    # Array to track available spaces for next moves.
    @possibleMoves = ['a1', 'b1', 'c1', 'a2', 'b2', 'c2', 'a3', 'b3', 'c3']

    # Board graphics
    @header =  '          A   B   C'
    @rowDiv =  '        +---+---+---+'

  end

  ###############################################
  ### Function: Check if errors exist
  ### params: none
  ### return: error or nil
  ###############################################
  def checkError
    return @error
  end

  ###############################################
  ### Function: Clear errors
  ### params: none
  ### return: none
  ###############################################
  def clearError
    @error = nil
  end

  ###############################################
  ### Function: Clear errors
  ### params: none
  ### return: none
  ###############################################
  def printBoard
    puts @header
    @board.each { |row, value|
      puts @rowDiv
      puts "    #{row}   | #{value["a"]} | #{value["b"]} | #{value["c"]} |"
    }
    puts @rowDiv
  end

  ###############################################
  ### Function: Get user input for move
  ### params: none
  ### return: none
  ###############################################
  def getInput
    # system "clear"
    printBoard
    puts "Where do you want to move? (Q to quit)"
    move = gets.chomp.downcase
    if move == 'q'
      winner(move)
    else
      playerMove(move)
    end
  end

  ###############################################
  ### Function: Add user's move to the board
  ### params: board location
  ### return: none
  ###############################################
  def playerMove(move)
    if !['a', 'b', 'c'].include?(move.chars.first) || !['1', '2', '3'].include?(move.chars.last)
      @error = "You entered an invalid move."
      return @error
    elsif !@possibleMoves.include?(move)
      @error = "Location already taken, please choose an available space."
      return @error
    else
      @possibleMoves.delete(move)
      # Reverse order of move from 'B2' to '2b' to match @board object
      move = move.chars.last + move.chars.first

      @board[move.chars.first.to_i][move.chars.last] = @player

      # Check if the move completes a winning row
      winner?
      unless @possibleMoves.length == 0
        computerMove
      end
    end
  end

  ###############################################
  ### Function: Add computer's move to the board
  ### params: none
  ### return: none
  ###############################################
  def computerMove
    random = rand(@possibleMoves.length)
    move = @possibleMoves[random]
    @possibleMoves.delete(move)
    @board[move.chars.last.to_i][move.chars.first] = @comp

    winner?

  end

  def checkRowWinner
    # Check each row for equality
    1.upto(@size) { |row|
      # Does row contain a player's move?
      if @board[row].value?('X') || @board[row].value?('O')
        if @board[row].values.uniq.size == 1
          winner(@board[row].values.uniq[0])
        end
      end
    }
  end

  def checkColumnWinner
    # Check each column for equality
    rows = @board.keys
    0.upto(@size - 1) { |col|
      column = []
      rows.each { |row|
        column.push(@board[row][@alphabet[col]])
      }
      if column.uniq.size == 1 && column.uniq[0] != ' '
        winner(column.uniq[0])
      end
    }
  end

  def checkDiagonalWinner
    # Check Top-left to Bottom-right Diagonal equality
    result = []
    rows = @board.keys
    rows.each_with_index {|row, index|
      result.push(@board[row][@alphabet[index]])
    }
    if result.uniq.size == 1 && result.uniq[0] != ' '
      winner(result.uniq[0])
    end

    # Check Top-left to Bottom-right Diagonal equality
    result = []
    rows.reverse.each_with_index {|row, index|
      result.push(@board[row][@alphabet[index]])
    }
    if result.uniq.size == 1 && result.uniq[0] != ' '
      winner(result.uniq[0])
    end
  end
  ###############################################
  ### Function: Check if there is a winner
  ### params: none
  ### return: string 'X' or 'O' if there is a winner
  ###############################################
  def winner?
    checkRowWinner
    checkColumnWinner
    checkDiagonalWinner

    # If none of the winner checks results in a win, check
    # for available spaces on the board. If none, game ends.
    if @possibleMoves.length == 0
      winner('Draw')
    end

  end

  ##################################################################
  ### Function: End the game if there is a win, draw, or user quits
  ### params: board location
  ### return: none
  ##################################################################
  def winner(player)
    system "clear"
    if player == 'Draw'
      printBoard
      puts "The game is a tie. Wah wahhh... :("
      endGame
    elsif player == 'q'
      puts "Goodbye!"
      endGame
    else
      printBoard
      puts "#{player} has won!"
      endGame
    end
  end

  def endGame
    exit
  end

end
