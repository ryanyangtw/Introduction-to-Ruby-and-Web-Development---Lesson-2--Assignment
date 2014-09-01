#require "pry"
#require "ap"

class Card
	attr_accessor :suit, :value

	def initialize(s,v)
		self.suit = s
		self.value = v
	end

	def to_s
		"This is the card! #{suit}, #{value}"
	end

end


class Deck
	attr_accessor :cards

	def initialize(num_decks)
		self.cards = []
		['H','D','S','C'].each do |suit|
			['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
				self.cards << Card.new(suit, face_value)
			end
		end
		self.cards = self.cards * num_decks
		scramble!
	end

	def scramble!
		self.cards.shuffle!
	end

	def deal!
		self.cards.pop
	end
end


class GameParticipant
	attr_accessor :cards
	
	def initialize() 
		self.cards = []
	end

	def total
		calculate_total
	end

	def get_card(card)
		self.cards << card
	end

	def calculate_total
		
		temp_total = 0 
		ace_count = 0

		self.cards.each do |card|

			if card.value == "A"
				temp_total += 11
				ace_count += 1
			elsif card.value.to_i == 0 # J, Q, K
				temp_total += 10
			else
				temp_total += card.value.to_i
			end
		end

		ace_count.times do
			temp_total -= 10 if temp_total > 21
		end

		temp_total
	end

end


class Player < GameParticipant
	attr_accessor :name
end

class Dealer < GameParticipant
	
end

class Blackjack

	attr_accessor :player, :dealer, :deck
	
	def initialize
		self.player = Player.new
		self.dealer = Dealer.new
		self.deck = Deck.new(4)
	end

	def run

		puts "Welcome to Blackjack! What's you name?"
		name = gets.chomp
		self.player.name = name
		puts ""


		begin
			init_deal!

			if(!player_turn)
				if(!dealer_turn)
					compare_hands
				end
			end


			while true
				
				puts "#{self.player.name}, Do you want to continue the game? Please enter 1) continue 2) stop"
				continue_or_stop = gets.chomp

				if !['1', '2'].include?(continue_or_stop)
					puts "Error: you must enter 1 or 2"
					next
				else
					break
				end
		  end

		end while(continue_or_stop == "1")
		puts "OK, BYE!"

	end


	private

	def init_deal!

		self.player.cards.clear
	  self.dealer.cards.clear

		self.player.get_card(self.deck.deal!)
		self.dealer.get_card(self.deck.deal!)
		self.player.get_card(self.deck.deal!)
		self.dealer.get_card(self.deck.deal!)

		# Show Cards
		puts "Dealer has: #{self.dealer.cards[0].value} and #{self.dealer.cards[1].value}, for a total of #{self.dealer.total}"
		puts "You have: #{self.player.cards[0].value} and #{self.player.cards[1].value}, for a total of: #{self.player.total}"
		puts ""
	end


	def player_turn
		#player turn
		#return true repreaent game is over
		if(self.player.total == 21)
			puts "Congratulations, you hit blackjack! #{self.player.name} you win"
			puts ""
			#exit
			return true
		end

		while self.player.total  < 21
			puts "#{self.player.name}, What would you like to do 1) hit )2 stay"
			
			hit_or_stay = gets.chomp
			if !['1', '2'].include?(hit_or_stay)
				puts "Error: you must enter 1 or 2"
				puts ""
				next
			end

			if hit_or_stay == "2"
				puts "#{self.player.name}, You chose to stay."
				puts ""
				return false
				#break
			end

			#hit
			new_card = self.deck.deal!
			puts "Dealing card to player #{new_card}"
			self.player.get_card(new_card)
			puts "#{self.player.name}, Now your total is #{self.player.total}"
			puts ""

			if self.player.total  == 21	
		    puts "Congratulations, you hit blackjack! #{self.player.name} You win!"
		    puts ""
		    return true
		    #exit
		  elsif self.player.total  > 21
		    puts "Sorry #{self.player.name}, it looks like you busted!"
		    puts ""
		    return true
		    #exit
		  end
		end
	end


	def dealer_turn		
		#Dealer turn
		#return true repreaent game is over
		if self.dealer.total == 21
			puts "Sorry, dealer hit blackhack. You lose."
			return true
			#exit
		end

		while self.dealer.total < 17

			new_card = self.deck.deal!
			self.dealer.get_card(new_card)
			puts "Dealing new card for dealer: #{new_card}"
			puts "Dealer total is now: #{self.dealer.total}"
			puts ""

		  if self.dealer.total == 21
		    puts "Sorry, dealer hit blackjack. You lose."
		    puts ""
		    return true
		    #exit
		  elsif self.dealer.total > 21
		    puts "Congratulations, dealer busted! You win!"
		    puts ""
		    return true
		    #exit
		  end
		end

		return false		
	end

	def compare_hands

		puts "Dealer's cards: "
		self.dealer.cards.each do |card|
		  puts "=> #{card}"
		end
		puts "Dealer's  total is #{self.dealer.total}"
		puts ""

		puts "Your cards:"
		self.player.cards.each do |card|
		  puts "=> #{card}"
		end
		puts "Your total is #{self.player.total}"
		puts ""

		if self.dealer.total > self.player.total
			puts "Sorry, dealer wins"
		elsif self.dealer.total < self.player.total
			puts "Congratulations, you win!" 
		else
  		puts "It's a tie!"
		end			
	end
end


Blackjack.new.run

