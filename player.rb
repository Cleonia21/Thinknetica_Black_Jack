class Player

  attr_accessor :dollars, :hand
  attr_reader :name

  def initialize(name = 'dealer')
    @hand = nil
    @dollars = 100
    @name = name
  end

  def subtract_dollars(num = 10)
    @dollars -= num
  end

  def add_dollars(num = 20)
    @dollars += num
  end

end
