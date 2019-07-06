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
end

class Square
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'

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
    puts "Choose square 1-9"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Invalid choice"
    end

    board.set_square_at(square, Square.new(HUMAN_MARKER))
  end

  def play
    display_welcome_message
    # loop do
      display_board
      human_moves
      display_board
    #   break if someone_won? || board_full?
    #
    #   computer_moves
    #   break if someone_won? || board_full?
    # end
    # display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
