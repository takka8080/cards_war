class Game
  def run
    puts "戦争を開始します。"
    puts "カードが配られました。"

    flag = true

    while(flag == true)
      puts "戦争！"

      flag = game_rule
    end

    puts "戦争を終了します。"
  end

  def game_rule
    cards = Cards.new
    player1 = cards.run[0]
    player2 = cards.run[1]

    if cards.cards_data[:"#{player1[0]}"].to_i == cards.cards_data[:"#{player2[0]}"].to_i
      puts "プレイヤー1のカードは#{player1[0]}"
      puts "プレイヤー2のカードは#{player2[0]}"
      puts "引き分けです。"
      return true
    elsif cards.cards_data[:"#{player1[0]}"].to_i > cards.cards_data[:"#{player2[0]}"].to_i
      puts "プレイヤー1のカードは#{player1[0]}"
      puts "プレイヤー2のカードは#{player2[0]}"
      puts "プレイヤー1が勝ちました。"
      return false
    elsif cards.cards_data[:"#{player1[0]}"].to_i < cards.cards_data[:"#{player2[0]}"].to_i
      puts "プレイヤー1のカードは#{player1[0]}"
      puts "プレイヤー2のカードは#{player2[0]}"
      puts "プレイヤー2が勝ちました。"
      return false
    end
  end
end

class Cards
  def run
    cards = cards_data

    distribute_cards(cards)
  end

  def cards_data
    { スペードのA: 13, スペードの2: 1, スペードの3: 2, スペードの4: 3, スペードの5: 4, スペードの6: 5, スペードの7: 6, スペードの8: 7, スペードの9: 8, スペードの10: 9, スペードのJ: 10, スペードのQ: 11, スペードのK: 12, ハートのA: 13, ハートの2: 1, ハートの3: 2, ハートの4: 3, ハートの5: 4, ハートの6: 5, ハートの7: 6, ハートの8: 7, ハートの9: 8, ハートの10: 9, ハートのJ: 10, ハートのQ: 11, ハートのK: 12, ダイヤのA: 13, ダイヤの2: 1, ダイヤの3: 2, ダイヤの4: 3, ダイヤの5: 4, ダイヤの6: 5, ダイヤの7: 6, ダイヤの8: 7, ダイヤの9: 8, ダイヤの10: 9, ダイヤのJ: 10, ダイヤのQ: 11, ダイヤのK: 12, クラブのA: 13, クラブの2: 1, クラブの3: 2, クラブの4: 3, クラブの5: 4, クラブの6: 5, クラブの7: 6, クラブの8: 7, クラブの9: 8, クラブの10: 9, クラブのJ: 10, クラブのQ: 11, クラブのK: 12 }
  end

  def distribute_cards(cards)
    cards_name = cards.keys.shuffle
    player1 = []
    player2 = []
    
    for i in 0..51
      if (i + 1) % 2 != 0
        player1 << cards_name[i]
      else
        player2 << cards_name[i]
      end
    end

    return player1, player2
  end
end

cards = Game.new
cards.run