class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], #last row
    [0,3,6], #left
    [1,4,7], #Middle
    [2,5,8], #right
    [0,4,8], #diagonal
    [2,4,6] #diagonal
  ]

  def initialize
    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input = input.to_i
    input-=1
  end

  def move(index, token)
    token ||= 'X'
    @board[index] = token
  end

  def position_taken?(index) #Note, this is true value 0 to 8
    return false if @board[index] == ' '
    return true
  end

  def input_to_index(input)
    input = input.to_i
    input-=1
  end

  def move(index, token = 'X') #default value is x. Pass in O to change player
    @board[index] = token
  end

  def valid_move?(position)
    return true if (position.between?(0,8) && !position_taken?(position))
    return false
  end

  def turn
    position = -1
    while !valid_move?(position) do
      puts "What is your move? Enter a number 1 - 9"
      input = gets.chomp
      position = input_to_index(input) #converted to 0 - 8
      if valid_move?(position)
        token = current_player
        move(position, token)
        display_board
        return
      end
    end
  end

  def turn_count
    turn_count = @board.count { |element| element != ' ' }
  end

  def current_player
    turn_count % 2 == 0 ? 'X' : 'O'
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if (@board[combo[0]] == 'X' && @board[combo[1]] == 'X' && @board[combo[2]] =='X')
        return combo
      elsif (@board[combo[0]] == 'O' && @board[combo[1]] == 'O' && @board[combo[2]] =='O')
        return combo
      else
        next
      end
    end
    return false
  end

  def full?
    return true if (@board.select { |element| element == ' ' }.count == 0)
  end

  def draw?
    return true if (full? && !won?)
  end

  def over?
    return true if (draw? || won?)
  end

  def winner
    current_player
  end

  def play
    while !over?
      display_board
      turn
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end
end
