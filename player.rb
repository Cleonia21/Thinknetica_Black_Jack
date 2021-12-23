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


end
