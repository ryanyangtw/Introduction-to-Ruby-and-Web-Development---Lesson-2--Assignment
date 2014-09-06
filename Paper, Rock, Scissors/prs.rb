require 'pry'


class GameParticipant
  attr_accessor :choice
end


class Prs
  attr_accessor :player, :computer
  CHOICES = {"P"=>"Paper", "R"=>"Rock", "S"=>"Scissors"}

  def initialize
    @player = GameParticipant.new
    @computer = GameParticipant.new
  end

  def player_turn
    begin 
      puts 'Pick one: (P/R/S)'
      player_choice = gets.chomp
      player_choice.upcase!
    end  until CHOICES.keys.include?(player_choice)
    self.player.choice = player_choice
  end

  def computer_turn
    self.computer.choice = CHOICES.keys.sample
  end

  def display_winning_message
    puts "you picked #{CHOICES[self.player.choice]} and computer picked #{CHOICES[self.computer.choice]}. "
  end

  def who_won?
    if self.player.choice == self.computer.choice
      display_winning_message
      puts "It's a tie!"
    elsif (self.player.choice == 'P' && self.computer.choice == 'R') || (self.player.choice == 'R' && self.computer.choice == 'S') ||(self.player.choice == 'S' && self.computer.choice == 'P')
      display_winning_message
      puts "You won!"
    else
      display_winning_message
      puts "Computer won!"
    end
  end

  def play_again?
    loop do
      puts 'Play again? (Y/N)'
      response = gets.chomp
      response.upcase!


      if !['Y','N'].include?(response)
        puts "Error: you must enter Y or N"
        next
      end

      if response == "Y"
        puts "---- Starting a new Game ----"
        start
      else
        puts "OK, Bye!"
        exit
      end
    end
  end

  def greet
    puts 'Play Ppaer Rock Scissors!'
  end

  def start
    greet
    player_turn
    computer_turn
    who_won?
    play_again?
  end

end

game = Prs.new
game.start
