require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  INITIAL_MARKER = ' '

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(square, marker)
    @squares[square] = marker
  end

  def [](index)
    squares[index]
  end

  def empty_squares_keys
    squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    empty_squares_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  # return marker or nil
  def detect_winner
    WINNING_LINES.each do |line|
      # binding.pry
      if (@squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
      @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
      @squares[line[2]].marker == TTTGame::HUMAN_MARKER )
        return TTTGame::HUMAN_MARKER
      elsif (@squares[line[0]].marker == TTTGame::COMPUTER_MARKER &&
      @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
      @squares[line[2]].marker == TTTGame::COMPUTER_MARKER )
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  # private

  attr_reader :squares
end

class Square
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    @marker == Board::INITIAL_MARKER
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def display_welcome_message
    puts "Welcome to TTT."
  end

  def display_goodbye_message
    puts "Thanks for playing."
  end

  def human_moves
    # binding.pry
    puts "Choose square #{board.empty_squares_keys}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.empty_squares_keys.include?(square)
      puts "Invalid choice"
    end

    board.set_square_at(square, Square.new(HUMAN_MARKER))
  end

  def computer_moves
    square = board.empty_squares_keys.sample
    board.set_square_at(square, Square.new(COMPUTER_MARKER))
  end

  def display_result
    if board.detect_winner == HUMAN_MARKER
      puts "You won!"
    elsif board.detect_winner == COMPUTER_MARKER
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      break if board.full? || board.someone_won?

      computer_moves
      break if board.full? || board.someone_won?
    end
    display_board
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
