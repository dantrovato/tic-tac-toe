require 'pry'

class Board
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

  # private

  attr_reader :squares, :marker
end

class Square
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

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      break if board.full? # || someone_won?

      computer_moves
      break if board.full? # || someone_won?
      display_board
    end
     # display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
