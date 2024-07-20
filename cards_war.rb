require 'debug'

class Game
  def run
    puts "戦争を開始します。"

    cards = Cards.new
    player_hand = cards.run
    player1_hand = player_hand[0]
    player2_hand = player_hand[1]
    cards_data = cards.cards_data

    puts "カードが配られました。"

    flag = true

    while(flag == true)
      puts "戦争！"

      game_rule(player1_hand, player2_hand, cards_data)

      flag = judge(player1_hand, player2_hand)
    end

    puts "戦争を終了します。"
  end

  def game_rule(player1_hand, player2_hand, cards_data)
    #binding.break

    @field = @field.to_a.push(player1_hand[0], player2_hand[0])
      
    if cards_data[:"#{player1_hand[0]}"].to_i == cards_data[:"#{player2_hand[0]}"].to_i
      puts "プレイヤー1のカードは#{player1_hand[0]}"
      puts "プレイヤー2のカードは#{player2_hand[0]}"
      puts "引き分けです。"

      player1_hand.delete_at(0)
      player2_hand.delete_at(0)
    elsif cards_data[:"#{player1_hand[0]}"].to_i > cards_data[:"#{player2_hand[0]}"].to_i
      puts "プレイヤー1のカードは#{player1_hand[0]}"
      puts "プレイヤー2のカードは#{player2_hand[0]}"
      puts "プレイヤー1が勝ちました。プレイヤー1はカードを#{@field.size}枚もらいました。"

      player1_hand.delete_at(0)
      player2_hand.delete_at(0)
      @player1_take = @player1_take.to_a.push(@field).flatten!
      @field = []
    elsif cards_data[:"#{player1_hand[0]}"].to_i < cards_data[:"#{player2_hand[0]}"].to_i
      puts "プレイヤー1のカードは#{player1_hand[0]}"
      puts "プレイヤー2のカードは#{player2_hand[0]}"
      puts "プレイヤー2が勝ちました。プレイヤー2はカードを#{@field.size}枚もらいました。"
      
      player1_hand.delete_at(0)
      player2_hand.delete_at(0)
      @player2_take = @player2_take.to_a.push(@field).flatten!
      @field = []
    end

    if player1_hand == []
      player1_hand.to_a.push(@player1_take).flatten!
      player1_hand.shuffle!
      @player1_take = []
    end

    if player2_hand == []
      player2_hand.to_a.push(@player2_take).flatten!
      player2_hand.shuffle!
      @player2_take = []
    end
  end

  def judge(player1_hand, player2_hand)
    if player1_hand == [] && @player1_take == []
      num = player2_hand.size + @player2_take.size
      puts "プレイヤー1の手札がなくなりました。"
      puts "プレイヤー1の手札の枚数は0枚です。プレイヤー2の手札は#{num}枚です。"
      puts "プレイヤー2が1位、プレイヤー1が2位です。"
      return false
    elsif player2_hand == [] && @player2_take == []
      num = player1_hand.size + @player1_take.size
      puts "プレイヤー2の手札がなくなりました。"
      puts "プレイヤー1の手札の枚数は#{num}枚です。プレイヤー2の手札は0枚です。"
      puts "プレイヤー1が1位、プレイヤー2が2位です。"
      return false
    end

    return true
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