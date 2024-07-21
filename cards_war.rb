require 'debug'

class Game
  def run
    #binding.break
    puts "戦争を開始します。"
    print('プレイヤーの人数を入力してください（2〜5）：')
    people = gets.chomp.to_i

    if !(people >= 2 && people <= 5)
      raise "2〜5を入力してください。"
    end

    for i in 1..people
      print "プレイヤー#{i}の名前を入力してください："
      name = gets.chomp
      player_name = player_name.to_a.push(name)
    end

    cards = Cards.new(people)
    player_hand = cards.run
    cards_data = cards.cards_data

    puts "カードが配られました。"

    flag = true

    while(flag == true)
      puts "戦争！"

      game_rule(people, player_hand, player_name, cards_data)

      flag = judge(people, player_hand, player_name)
    end

    puts "戦争を終了します。"
  end

  def game_rule(people, player_hand, player_name, cards_data)
    #binding.break
    
    @field = @field.to_a
    @best = @best.to_h
    judge = {}
    
    if @best == {}
      for i in 1..people
        case i
        when 1
          puts "#{player_name[0]}のカードは#{player_hand[0][0]}です。"
          judge.store(:player1, cards_data[:"#{player_hand[0][0]}"])
          @field << player_hand[0][0]
          player_hand[0].delete_at(0)
        when 2
          puts "#{player_name[1]}のカードは#{player_hand[1][0]}です。"
          judge.store(:player2, cards_data[:"#{player_hand[1][0]}"])
          @field << player_hand[1][0]
          player_hand[1].delete_at(0)
        when 3
          puts "#{player_name[2]}のカードは#{player_hand[2][0]}です。"
          judge.store(:player3, cards_data[:"#{player_hand[2][0]}"])
          @field << player_hand[2][0]
          player_hand[2].delete_at(0)
        when 4
          puts "#{player_name[3]}のカードは#{player_hand[3][0]}です。"
          judge.store(:player4, cards_data[:"#{player_hand[3][0]}"])
          @field << player_hand[3][0]
          player_hand[3].delete_at(0)
        when 5
          puts "#{player_name[4]}のカードは#{player_hand[4][0]}です。"
          judge.store(:player5, cards_data[:"#{player_hand[4][0]}"])
          @field << player_hand[4][0]
          player_hand[4].delete_at(0)
        end
      end
    else
      if @best.has_key?(:player1)
        puts "#{player_name[0]}のカードは#{player_hand[0][0]}です。"
        judge.store(:player1, cards_data[:"#{player_hand[0][0]}"])
        @field << player_hand[0][0]
        player_hand[0].delete_at(0)
      end

      if @best.has_key?(:player2)
        puts "#{player_name[1]}のカードは#{player_hand[1][0]}です。"
        judge.store(:player2, cards_data[:"#{player_hand[1][0]}"])
        @field << player_hand[1][0]
        player_hand[1].delete_at(0)
      end

      if @best.has_key?(:player3)
        puts "#{player_name[2]}のカードは#{player_hand[2][0]}です。"
        judge.store(:player3, cards_data[:"#{player_hand[2][0]}"])
        @field << player_hand[2][0]
        player_hand[2].delete_at(0)
      end
      
      if @best.has_key?(:player4)
        puts "#{player_name[3]}のカードは#{player_hand[3][0]}です。"
        judge.store(:player4, cards_data[:"#{player_hand[3][0]}"])
        @field << player_hand[3][0]
        player_hand[3].delete_at(0)
      end

      if @best.has_key?(:player5)
        puts "#{player_name[4]}のカードは#{player_hand[4][0]}です。"
        judge.store(:player5, cards_data[:"#{player_hand[4][0]}"])
        @field << player_hand[4][0]
        player_hand[4].delete_at(0)
      end
    end

    max_v = judge.values.max
    @best = judge.select{ |k, v| v == max_v }

    if @best.size == 1
      case @best.keys
      when [:player1]
        puts "#{player_name[0]}が勝ちました。#{player_name[0]}はカードを#{@field.size}枚もらいました。"
        @player1_take = @player1_take.to_a.push(@field).flatten!
        @field = []
        @best = {}
      when [:player2]
        puts "#{player_name[1]}が勝ちました。#{player_name[1]}はカードを#{@field.size}枚もらいました。"
        @player2_take = @player2_take.to_a.push(@field).flatten!
        @field = []
        @best = {}
      when [:player3]
        puts "#{player_name[2]}が勝ちました。#{player_name[2]}はカードを#{@field.size}枚もらいました。"
        @player3_take = @player3_take.to_a.push(@field).flatten!
        @field = []
        @best = {}
      when [:player4]
        puts "#{player_name[3]}が勝ちました。#{player_name[3]}はカードを#{@field.size}枚もらいました。"
        @player4_take = @player4_take.to_a.push(@field).flatten!
        @field = []
        @best = {}
      when [:player5]
        puts "#{player_name[4]}が勝ちました。#{player_name[4]}はカードを#{@field.size}枚もらいました。"
        @player5_take = @player5_take.to_a.push(@field).flatten!
        @field = []
        @best = {}
      end
    else
      puts "引き分けです。"
    end

    if player_hand[0] == []
      player_hand[0].push(@player1_take.to_a).flatten!
      player_hand[0].shuffle!
      @player1_take = []
    end

    if player_hand[1] == []
      player_hand[1].push(@player2_take.to_a).flatten!
      player_hand[1].shuffle!
      @player2_take = []
    end

    if player_hand[2] == []
      player_hand[2].push(@player3_take.to_a).flatten!
      player_hand[2].shuffle!
      @player3_take = []
    end

    if player_hand[3] == []
      player_hand[3].push(@player4_take.to_a).flatten!
      player_hand[3].shuffle!
      @player4_take = []
    end

    if player_hand[4] == []
      player_hand[4].push(@player5_take.to_a).flatten!
      player_hand[4].shuffle!
      @player5_take = []
    end
  end

  def judge(people, player_hand, player_name)
    #binding.break
    flag = false

    if player_hand[0] == [] && @player1_take.to_a == []
      puts "#{player_name[0]}の手札がなくなりました。"
      flag = true
    end

    if player_hand[1] == [] && @player2_take.to_a == []
      puts "#{player_name[1]}の手札がなくなりました。"
      flag = true
    end

    if player_hand[2] == [] && @player3_take.to_a == []
      puts "#{player_name[2]}の手札がなくなりました。"
      flag = true
    end

    if player_hand[3] == [] && @player4_take.to_a == []
      puts "#{player_name[3]}の手札がなくなりました。"
      flag = true
    end

    if player_hand[4] == [] && @player5_take.to_a == []
      puts "#{player_name[4]}の手札がなくなりました。"
      flag = true
    end

    if flag == true
      rank_num = []
      last_num = 0
      j = 1
      rank = {}
      num1 = player_hand[0].to_a.size + @player1_take.to_a.size
      num2 = player_hand[1].to_a.size + @player2_take.to_a.size
      num3 = player_hand[2].to_a.size + @player3_take.to_a.size
      num4 = player_hand[3].to_a.size + @player4_take.to_a.size
      num5 = player_hand[4].to_a.size + @player5_take.to_a.size

      case people
      when 2
        rank.store(:"#{player_name[0]}", "#{num1}")
        rank.store(:"#{player_name[1]}", "#{num2}")
        rank = rank.sort_by{|k, v| v}.reverse.to_h

        puts "#{player_name[0]}の手札の枚数は#{num1}枚です。#{player_name[1]}の手札の枚数は#{num2}枚です。"
        puts "#{rank.keys[0]}が1位、#{rank.keys[1]}が2位です。"
        
        return false
      when 3
        rank.store(:"#{player_name[0]}", "#{num1}")
        rank.store(:"#{player_name[1]}", "#{num2}")
        rank.store(:"#{player_name[2]}", "#{num3}")
        rank = rank.sort_by{|k, v| v}.reverse.to_h

        rank.values.each.with_index(1) do |num, i|
          if i == 1
            last_num = num
          end
        
          if num != last_num
            j = i
            rank_num << j
            last_num = num
          else
            last_num = num
            rank_num << j
          end
        end

        puts "#{player_name[0]}の手札の枚数は#{num1}枚です。#{player_name[1]}の手札の枚数は#{num2}枚です。#{player_name[2]}の手札の枚数は#{num3}枚です。"
        puts "#{rank.keys[0]}が#{rank_num[0]}位、#{rank.keys[1]}が#{rank_num[1]}位、#{rank.keys[2]}が#{rank_num[2]}位です。"
        
        return false
      when 4
        rank.store(:"#{player_name[0]}", num1)
        rank.store(:"#{player_name[1]}", num2)
        rank.store(:"#{player_name[2]}", num3)
        rank.store(:"#{player_name[3]}", num4)
        rank = rank.sort_by{|k, v| v}.reverse.to_h

        rank.values.each.with_index(1) do |num, i|
          if i == 1
            last_num = num
          end
        
          if num != last_num
            j = i
            rank_num << j
            last_num = num
          else
            last_num = num
            rank_num << j
          end
        end

        puts "#{player_name[0]}の手札の枚数は#{num1}枚です。#{player_name[1]}の手札の枚数は#{num2}枚です。#{player_name[2]}の手札の枚数は#{num3}枚です。#{player_name[3]}の手札の枚数は#{num4}枚です。"
        puts "#{rank.keys[0]}が#{rank_num[0]}位、#{rank.keys[1]}が#{rank_num[1]}位、#{rank.keys[2]}が#{rank_num[2]}位、#{rank.keys[3]}が#{rank_num[3]}位です。"
        
        return false
      when 5
        rank.store(:"#{player_name[0]}", num1)
        rank.store(:"#{player_name[1]}", num2)
        rank.store(:"#{player_name[2]}", num3)
        rank.store(:"#{player_name[3]}", num4)
        rank.store(:"#{player_name[4]}", num5)
        rank = rank.sort_by{|k, v| v}.reverse.to_h

        rank.values.each.with_index(1) do |num, i|
          if i == 1
            last_num = num
          end
        
          if num != last_num
            j = i
            rank_num << j
            last_num = num
          else
            last_num = num
            rank_num << j
          end
        end

        puts "#{player_name[0]}の手札の枚数は#{num1}枚です。#{player_name[1]}の手札の枚数は#{num2}枚です。#{player_name[2]}の手札の枚数は#{num3}枚です。#{player_name[3]}の手札の枚数は#{num4}枚です。#{player_name[4]}の手札の枚数は#{num5}枚です。"
        puts "#{rank.keys[0]}が#{rank_num[0]}位、#{rank.keys[1]}が#{rank_num[1]}位、#{rank.keys[2]}が#{rank_num[2]}位、#{rank.keys[3]}が#{rank_num[3]}位、#{rank.keys[4]}が#{rank_num[4]}位です。"
        
        return false
      end
    end

    return true
  end
end

class Cards
  def initialize(people)
    @people = people
  end

  def run
    cards = cards_data

    distribute_cards(cards)
  end

  def cards_data
    cards = { スペードのA: 13, スペードの2: 1, スペードの3: 2, スペードの4: 3, スペードの5: 4, スペードの6: 5, スペードの7: 6, スペードの8: 7, スペードの9: 8, スペードの10: 9, スペードのJ: 10, スペードのQ: 11, スペードのK: 12, ハートのA: 13, ハートの2: 1, ハートの3: 2, ハートの4: 3, ハートの5: 4, ハートの6: 5, ハートの7: 6, ハートの8: 7, ハートの9: 8, ハートの10: 9, ハートのJ: 10, ハートのQ: 11, ハートのK: 12, ダイヤのA: 13, ダイヤの2: 1, ダイヤの3: 2, ダイヤの4: 3, ダイヤの5: 4, ダイヤの6: 5, ダイヤの7: 6, ダイヤの8: 7, ダイヤの9: 8, ダイヤの10: 9, ダイヤのJ: 10, ダイヤのQ: 11, ダイヤのK: 12, クラブのA: 13, クラブの2: 1, クラブの3: 2, クラブの4: 3, クラブの5: 4, クラブの6: 5, クラブの7: 6, クラブの8: 7, クラブの9: 8, クラブの10: 9, クラブのJ: 10, クラブのQ: 11, クラブのK: 12 }

    if @people == 2 || @people == 4
      return cards
    elsif @people == 3
      cards.delete(:スペードの2)
      return cards
    elsif @people == 5
      cards.delete(:スペードの2)
      cards.delete(:ハートの2)
      return cards
    end
  end

  def distribute_cards(cards)
    cards_name = cards.keys.shuffle
    num = cards_name.size
    player_hand = []
    
    if @people == 2
      num /= 2

      cards_name.each_slice(num) do |c|
        player_hand << c
      end

      return player_hand
    elsif @people == 3
      num /= 3

      cards_name.each_slice(num) do |c|
        player_hand << c
      end

      return player_hand
    elsif @people == 3
      num /= 3

      cards_name.each_slice(num) do |c|
        player_hand << c
      end

      return player_hand
    elsif @people == 4
      num /= 4

      cards_name.each_slice(num) do |c|
        player_hand << c
      end

      return player_hand
    elsif @people == 5
      num /= 5

      cards_name.each_slice(num) do |c|
        player_hand << c
      end

      return player_hand
    end
  end
end

cards = Game.new
cards.run