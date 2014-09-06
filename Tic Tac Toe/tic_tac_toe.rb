
require 'pry'

class Board
  attr_accessor :b
  
  def initialize
    @b = {}
    (1..9).each {|position| b[position] = ' '}
  end

  def empty_positions
    self.b.keys.select{ |position| b[position] == ' '}
  end

  def record(position, val)
    self.b[position] = val
  end

  def draw
    puts
    puts "     |     |"
    puts "  #{self.b[1]}  |  #{self.b[2]}  |  #{self.b[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.b[4]}  |  #{self.b[5]}  |  #{self.b[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.b[7]}  |  #{self.b[8]}  |  #{self.b[9]}"
    puts "     |     |"
    puts
  end

  def ninie_postition_are_filled?
    empty_positions == []
  end

end

module Record
    attr_accessor :record_values

    def initialize
      #@record = Position.new
      @record_values = []
    end

    def record_position(p)
      self.record_values << p
    end

    def eliminate_record
      self.record_values.clear
    end
end

class Human
  include Record

  def pick_position(board)
    begin
      puts "Choiise a position (from 1 to 9) to place piece:"
      choice = gets.chomp.to_i
    end until board.empty_positions.include?(choice)
    board.record(choice, 'O')
    record_position(choice)
  end


end

class Computer
  include Record

  def pick_position(board)
    choice = board.empty_positions.sample
    board.record(choice , 'X')
    record_position(choice)
  end

end


class Tictactoe
  attr_accessor :board, :player, :computer

  def initialize
    @board = Board.new
    @player = Human.new
    @computer = Computer.new
  end

  def player_turn
    player.pick_position(self.board)
    board.draw
    check_winner
  end

  def computer_turn
    computer.pick_position(self.board)
    board.draw
    check_winner
  end   

  def check_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      if (line - player.record_values).empty?
        puts "You won!"
        play_again?
      elsif (line - computer.record_values).empty?
        puts "Computer won!"
        play_again?
      end      
    end
  end

  def play_again?
    puts ""
    puts "Would you lide to play again? 1) yes 2) no, exit"
    if gets.chomp == '1'
      puts "--- Starting new game ---"
      puts ""
      @board = Board.new
      self.player.eliminate_record
      self.computer.eliminate_record
      start
    else
      puts "GoodBye!"
      exit
    end
  end

  def start
    board.draw
    begin
      player_turn
      computer_turn
    end until board.ninie_postition_are_filled?

    puts "It's a tie!"
    play_again?
  end
end


Tictactoe.new.start



