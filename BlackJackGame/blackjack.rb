require 'pry'


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

	def initialize(num_dexks)
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

class player
end

class Dealer
end

class Blackjack
	def initialize
	end

	def run
	end
end


Blackjack.new.run


