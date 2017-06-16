###############################################
### Game Logic for TicTacToe
### Builds board, possible moves, win / lose / draw logic
###############################################

class TicTacToe
  def initialize(player)
    @error = nil
    @player = player
    if player == 'X'
      @comp = 'O'
    else
      @comp = 'X'
    end
    # Board to record player moves
    @size =
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

    @winner = nil
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
    printBoard
    puts "Where do you want to move? (Q to quit)"
    move = gets.chomp
    if move.downcase == 'q'
      @winner = 'Q'
    else
      playerMove(move.downcase)
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
    elsif !@possibleMoves.include?(move.downcase)
      @error = "Location already taken, please choose an available space."
      return @error
    else
      @possibleMoves.delete(move)
      # Reverse order of move from 'B2' to '2b' to match @board object
      move = move.chars.last + move.chars.first.downcase

      @board[move.chars.first][move.chars.last] = @player

      # Check if the move completes a winning row
      if winner? == @player
        printBoard
        @winner = @player
      elsif @possibleMoves.length == 0
        @winner = 'Draw'
      else
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
    @board[move.chars.last][move.chars.first.downcase] = @comp

    if winner? == @comp
      printBoard
      @winner = @comp
    elsif @possibleMoves.length == 0
      @winner = 'Draw'
      winner
    end
  end

  ###############################################
  ### Function: Check if there is a winner
  ### params: none
  ### return: string 'X' or 'O' if there is a winner
  ###############################################
  def winner?
    @winners.each { |line|
      check = []
      line.each { |el|
        check.push(@board[el.chars.last][el.chars.first])
      }
      if check == @oWin
        return 'O'
      elsif check == @xWin
        return 'X'
      end
    }
  end

  ##################################################################
  ### Function: End the game if there is a win, draw, or user quits
  ### params: board location
  ### return: none
  ##################################################################
  def winner
    printBoard
    if @winner == 'Draw'
      return "The game is a tie. Wah wahhh... :("
    elsif @winner == 'Q'
      return "Goodbye!"
    else
      return "#{@winner} has won!"
    end
  end

  ##################################################################
  ### Function: Exits while loop in tictactoe.rb
  ### params: none
  ### return: nil || 'X' || 'O'
  ##################################################################
  def gameover
    return @winner
  end

end
