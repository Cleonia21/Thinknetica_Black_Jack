class Interface

  def show_cards(player, dealer, winner)
    print_table(player, dealer, 'open')
    puts "#{winner} won, new game?(yes/no)"
    gets.chomp
  end

  def show_end(player, dealer, winner)
    print_table(player, dealer, 'open')
    print "#{winner} won"
    puts '. You are out of money, game over((' if player.name != winner
    puts '. You give all the money, game over))' if player.name == winner
    'exit'
  end

  def game_table(player, dealer, skip_limit)
    print_table(player, dealer, 'close')
    puts 'What do you want? {skip(1) / add card(2) / show cards(3)}' if skip_limit == false
    puts 'What do you want? {add card(2) / show cards(3)}' if skip_limit == true
    gets.chomp
  end

  def dealer_move(text)
    print "dealer #{text}"
    3.times do
      print '.'
      sleep 1
    end
    puts ''
  end

  def player_name
    puts 'print you name'
    gets.chomp
  end

  private

  def print_table(player, dealer, dealer_status)
    puts ''
    puts '---------------------'
    puts "#{dealer.name.upcase}:#{print_info(dealer, dealer_status)}"
    print_cards(dealer.cards, dealer_status)
    puts '/\/\/\/\/\/\/\/\/\/\\'
    print_cards(player.cards, 'open')
    puts "#{player.name.upcase}:#{print_info(player, 'open')}"
    puts '---------------------'
    puts ''
  end

  def print_info(player, status)
    score = player.count_points
    score = '*' if status == 'close'
    "   money #{player.dollars}$   score {#{score}}"
  end

  def print_cards(cards, status)
    pictures = []
    cards.each do |card|
      pictures << decode_card(-1) if status == 'close'
      pictures << decode_card(card) if status == 'open'
    end
    (0..6).each do |i|
      print pictures[0][i]
      print pictures[1][i]
      print pictures[2][i] unless pictures[2].nil?
      puts ''
    end
  end

  def decode_card(card)
    if card == -1
      card_value = -1
      card_suit = -1
    else
      card_value = card % 13
      card_suit = card / 13
    end
    picture = ['---------  ']
    value_char = (card_value + 2).to_s if card_value < 9
    value_char = 'В' if card_value == 9
    value_char = 'D' if card_value == 10
    value_char = 'K' if card_value == 11
    value_char = 'T' if card_value == 12
    value_char = '*' if card_value == -1
    suit_char = '♠' if card_suit == 0
    suit_char = '♥' if card_suit == 1
    suit_char = '♣' if card_suit == 2
    suit_char = '♦' if card_suit == 3
    suit_char = '*' if card_suit == -1
    picture << "| #{suit_char}     |  "
    picture << '|       |  '
    picture << "|   #{value_char}   |  " if value_char != '10'
    picture << "|   #{value_char}  |  " if value_char == '10'
    picture << '|       |  '
    picture << "|     #{suit_char} |  "
    picture << '---------  '
  end
end
