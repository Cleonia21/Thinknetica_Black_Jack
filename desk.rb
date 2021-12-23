class Deck
  def initialize
    @cards = (0...52).to_a.shuffle
  end

  def give_cards(num)
    new_desk = []
    num.times do
      card = Card.new(@cards[-1] % 13, @cards[-1] / 13)
      @cards.pop
      new_desk << card
    end
    new_desk
  end
end