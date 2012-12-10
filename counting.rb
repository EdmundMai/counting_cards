CARDS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
SUITS = %w{Diamonds Hearts Clubs Spades}

class Count
	def initialize(decks)
		@count = 4 - (4 * decks)
		@deck = []
		decks.times do
			CARDS.each do |card|
				SUITS.each do |suit|
					@deck << "#{card} of #{suit}"
				end
			end
		end
		@deck.shuffle!
		@cards = []
		@total_value = 0
	end

	def deal
		@cards = @deck.pop(2) unless @deck.size < 2
		@cards.each do |card|
			@count += 1 if card[/[2-7]/]
			@count -= 1 if card[/[(10)JQKA]/]
		end
		@cards
	end

	def hit
		@cards << @deck.pop(1)
		reorder
		@total_value = @cards.inject(0) do |sum, card|
			if card[/(10)JQK/]
				sum + 10
			elsif card[/A/]
				sum > 10 ? sum + 1 : sum + 11
			else
				sum + card[0].to_i
			end
		bust?
		@cards
		end
	end

	def self.reorder
		new_order = []
		@cards.each do |card|
			if card.include?("A")
				new_order.push(card)
			else
				new_order.unshift(card)
			end
		end
		@cards = new_order
	end


	def self.bust?
		if @total_value > 21 
			"Your bust with #{@total_value}. You lose."
			exit(1)
		elsif @total_value == 21
			"Blackjack!"
			exit(1)
		else
			"Your total value is #{@total_value}. Continue?"
		end
	end


end