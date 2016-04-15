class YankeeScore::CLI

  def initialize
    @score_scraper = YankeeScore::ScoreScraper.new
    @score_scraper.load_games
  end




  def call
    greet_user
    search_team("NYY")
    menu
  end

  def greet_user
    puts "Welcome to Yankee Score CLI"
  end

  def menu
    input = nil
    while input != "exit"
      puts
      puts "1. Search another team"
      puts "2. Show all teams"

      input = gets.strip

      case input
      when "1"
        list_games
        puts "Enter Team initials to select team."
        answer = gets.strip.upcase

        search_team(answer)
      when "2"
        print_games
      when "exit"
        bye_message
        exit
      else

      end
    end
  end

  def search_team(team_abbrev)
    games = YankeeScore::Game.find_team_by_abbrev(team_abbrev)
    games.each do |game|
        print_game(game)
    end
  end



  def print_game(game)
    puts
    puts "    ============"
    puts "     #{game.away_team.name} | #{game.away_team.runs || "-"}"
    puts "    -----------"
    puts "     #{game.home_team.name} | #{game.home_team.runs || "-"}"
    puts "    ============"
    puts
    puts "Game Start: #{game.start_time}" unless game.is_over?

    puts  "#{game.inning_state} #{game.inning.to_i.ordinalize}" if game.is_active?


    puts
    puts "Game Status: #{game.status}"
  end





  def print_games
    YankeeScore::Game.all.each do |game|
      puts "==============================="
      print_game(game)
      puts "==============================="
    end
  end

  def bye_message
    puts
    puts "Bye!"
    puts
    sleep 0.5
    puts "+----------------------------------------------+"
    puts "|  It ain't over till it's over. - Yogi Berra  |"
    puts "+----------------------------------------------+"
    puts
  end

  def list_games
    YankeeScore::Game.all.each do |game|
      puts "  #{game.away_team.name} @ #{game.home_team.name} #{game.score || game.start_time}"
    end
  end


end
