###############################################
### Game Logic for TicTacToe
### Builds board, possible moves, win / lose / draw logic
###############################################

class TicTacToe
  ###############################################
  ### Function: Initializes class
  ### params: Player (X or O), size of board
  ### return: none
  ###############################################
  def initialize(player, size = 3)
    if player.downcase != 'x' && player != 'o'
      raise ArgumentError.new("Player must be 'X' or 'O'.")
    end

    if size < 3 || size > 9
      raise ArgumentError.new("Table size must be between 3 and 26.")
    end
    @error = nil
    @player = player
    if player == 'X'
      @comp = 'O'
    else
      @comp = 'X'
    end
    @alphabet = ("a".."i").to_a
    @size = size
    @possibleMoves = []
    @board = {}
    # Set up board
    1.upto(@size) { |row|
      @board[row] = {}
      0.upto(@size - 1) { |column|
        # Array to track available spaces for next moves.
        @possibleMoves.push(@alphabet[column] + row.to_s)

        @board[row][@alphabet[column]] = " "
      }
    }
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
  ### Function: Prints board to terminal
  ### params: none
  ### return: none
  ###############################################
  def printBoard
    print  ' ' * 10
    @board.values[0].each { |key, val|
      print "#{key.upcase}   "
    }
    @board.each { |row, col|
      puts "\n" + " " * 8 + "+---" * @size + "+"
      print "    #{row}   |"
      col.each { |key, val|
        print  " #{val} |"
      }
    }
    puts
    puts " " * 8 + "+---" * @size + "+"
  end

  ###############################################
  ### Function: Get user input for move
  ### params: none
  ### return: none
  ###############################################
  def getInput
    system "clear"
    printBoard
    puts "You are player #{@player}"
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
    print @board.values[0].keys
    if !@board.values[0].keys.include?(move.chars.first) || !@board.keys.include?(move.chars.last.to_i)
      @error = "You entered an invalid move."
      return @error
    elsif !@possibleMoves.include?(move)
      @error = "Location already taken, please choose an available space."
      return @error
    else
      @possibleMoves.delete(move)

      # Reverse order of move from 'b2' to '2b' to match @board object
      move = move.chars.last + move.chars.first

      # Add move to board
      @board[move.chars.first.to_i][move.chars.last] = @player

      # Check if the move completes a winning row
      winner?

      # If that was the last available move, skip computer move
      unless @possibleMoves.length == 0
        computerMove
      end
    end
  end

  ###############################################
  ### Function: Add computer move to the board
  ### params: none
  ### return: none
  ###############################################
  def computerMove
    # Check if this is computer's first move
    if @possibleMoves.length >= (@size ** 2 - 1)
      # Pick middle square if available, else pick random
      if @possibleMoves.include?("b2")
        move = "b2"
      else
        random = rand(@possibleMoves.length)
        move = @possibleMoves[random]
      end
    else
      # If not first move, run bestMove algorithm
      move = bestMove
    end

    # Remove computer's move from possible moves.
    @possibleMoves.delete(move)

    # Add computer's move to board
    @board[move.chars.last.to_i][move.chars.first] = @comp

    # Check for a winner
    winner?
  end

  #############################################################################
  ### Function: Checks rows, then columns for best available move for computer
  ### params: none
  ### return: board location in form "a2"
  #############################################################################
  def bestMove
    rows = @board.keys

    # Iterate over rows
    rows.each { |row|
      # Does row contain a computer's move, a free space, and NO player move?
      if @board[row].value?(@comp) && @board[row].value?(" ") && @board[row].values.uniq.size == 2
          @board[row].keys.each { |col|
            # Take first available space
            if @board[row][col] == " "
              return col + row.to_s
            end
          }
      end
    }

    # Iterate over columns
    0.upto(@size - 1) { |col|
      column = []
      rows.each { |row|
        column.push(@board[row][@alphabet[col]])
      }
      # Does column contain a computer's move, a free space, and NO player move?
      if column.uniq.size == 2 && column.include?(" ") && column.include?(@comp)
        # Take first available space
        return @alphabet[col] + (column.index(" ") + 1).to_s
      end
    }

    # If no ideal move has been found in a row or column, generate random move
    random = rand(@possibleMoves.length)
    return @possibleMoves[random]
  end

  ###############################################
  ### Function: Check if there is a winning row
  ### params: none
  ### return: none
  ###############################################
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

  ###############################################
  ### Function: Check if there is a winning column
  ### params: none
  ### return: none
  ###############################################
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

  ###############################################
  ### Function: Check if there is a winning diagonal
  ### params: none
  ### return: none
  ###############################################
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

    # Check Top-right to Bottom-left Diagonal equality
    result = []
    rows.reverse.each_with_index {|row, index|
      result.push(@board[row][@alphabet[index]])
    }
    if result.uniq.size == 1 && result.uniq[0] != ' '
      winner(result.uniq[0])
    end
  end

  ###############################################
  ### Function: Check if there is a winner or a draw
  ### params: none
  ### return: none
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
  ### Function: Ends the game if there is a win, draw, or user quits
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
