class Player

  attr_accessor :cards, :dollars, :points
  attr_reader :name

  def initialize(name = 'dealer')
    @cards = []
    @dollars = 100
    @points = 0
    @name = name
  end

  def subtract_dollars(num = 10)
    @dollars -= num
  end

  def add_card(card)
    @cards << card
    count_points
  end

  def add_dollars(num = 20)
    @dollars += num
  end

  def count_points
    @points = 0
    @cards.each do |card|
      card %= 13
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
