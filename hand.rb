class Hand

  attr_reader :cards

  def initialize(cards)
    @cards = [cards].flatten
  end

  def add_card(card)
    @cards << card
    @cards.flatten!
  end

  def cards_num
    @cards.length
  end

  def points
    @points = 0
    @cards.each do |card|
      @points += card.value + 2 if card.value < 9
      @points += 10 if [9, 10, 11].include?(card.value)
      if @points + 11 <= 21 && card.value == 12
        @points += 11
      elsif card.value == 12
        @points += 1
      end
    end
    @points
  end
end
