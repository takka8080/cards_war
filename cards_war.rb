class Cards
  def create_cards
    cards = []

    for i in 1..4
      for n 1..13
        if i == 1
          cards << "スペードの" + i
        elsif i == 2
            cards << "ハートの" + i
        elsif i == 3
            cards << "ダイヤの" + i
        elsif i == 4
            cards << "クラブの" + i
        end
      end
    end

    return cards
  end
end

cards = Cards.new
puts card.create_cards