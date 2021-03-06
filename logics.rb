class Logics

  attr_reader :player, :dealer

  def initialize
    @cards = (0...52).to_a.shuffle
    @interface = Interface.new
    @player = Player.new(@interface.player_name)
    @dealer = Player.new
  end

  def process
    game_status = 'active'
    while game_status != 'exit'
      @player.cards = [@cards.pop, @cards.pop]
      @dealer.cards = [@cards.pop, @cards.pop]
      @player.subtract_dollars
      @dealer.subtract_dollars
      skip_limit = false
      game_status = 'active'
      while game_status == 'active'
        case @interface.game_table(@player, @dealer, skip_limit).to_s
        when 'skip', '1'
          dealer_move if skip_limit == false
          skip_limit = true
        when 'add card', '2'
          @player.add_card(@cards.pop)
          dealer_move if skip_limit == false
        when 'show cards', '3'
          game_status = game_over
        end
        game_status = game_over if @player.cards.length == 3
      end
    end
  end

  def game_over
    player_points = @player.count_points
    dealer_points = @dealer.count_points
    if player_points <= 21 && (player_points > dealer_points || dealer_points > 21)
      @player.add_dollars
      winner = @player.name
    elsif dealer_points <= 21 && (dealer_points > player_points || player_points > 21)
      @dealer.add_dollars
      winner = @dealer.name
    else
      @player.add_dollars(10)
      @dealer.add_dollars(10)
      winner = 'nobody'
    end
    game_status = @interface.show_cards(@player, @dealer, winner) unless @player.dollars.zero? || @dealer.dollars.zero?
    game_status = @interface.show_end(@player, @dealer, winner) if @player.dollars.zero? || @dealer.dollars.zero?
    game_status = 'exit' if %w[no n NO].include? game_status
    game_status
  end

  def dealer_move
    if @dealer.cards.length == 2 && @dealer.count_points < 17
      @dealer.add_card(@cards.pop)
      @interface.dealer_move('add card')
    else
      @interface.dealer_move('skip')
    end
  end
end
