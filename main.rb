require_relative 'interface'
require_relative 'logics'
require_relative 'player'

class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Hand

  attr_reader

  def initialize(cards)
    @cards = []
    @cards << cards
    @points = count_points
  end

  def count_points
    @points = 0
    @cards.each do |card|
      value = card.value % 13
      @points += card + 2 if card < 9
      @points += 10 if [9, 10, 11].include?(card)
      if @points + 11 <= 21 && card == 12
        @points += 11
      elsif card == 12
        @points += 1
      end
    end
    @points
  end
end

Logics.new.process
