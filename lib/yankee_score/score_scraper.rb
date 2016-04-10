class YankeeScore::ScoreScraper

  # def initialize(home_team = nil, away_team = nil)
  #   @home_team = home_team
  #   @away_team = away_team
  # end

  def date
    @date = Date.today
  end

  def data
      url =  "http://gd2.mlb.com/components/game/mlb/year_#{date.year}/month_#{date.strftime("%m")}/day_#{date.strftime("%d")}/master_scoreboard.json"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      @data = response.body
  end

# data.games.game[8].away_name_abbrev

  def json
    @json ||= JSON.parse(data, symbolize_names: true)
  end

  def games
    json[:data][:games][:game]
  end

  # def find_game(team = "NYY")
  #   games.find { |game|  game[:home_name_abbrev] == team || game[:away_name_abbrev]}
  # end

  def load_games
    games.each do |game_hash|
      g = YankeeScore::Game.new
      g.home_team = game_hash[:home_name_abbrev]
      g.away_team = game_hash[:away_name_abbrev]
      g.start_time = game_hash[:time]
      g.status = game_hash[:status][:status]
      g.inning = game_hash[:status][:inning]
      g.inning_state = game_hash[:status][:inning_state]

      if game_hash.has_key?(:linescore)
        g.runs = game_hash[:linescore][:r]
        g.home_team_runs = game_hash[:linescore][:r][:home]
        g.away_team_runs = game_hash[:linescore][:r][:away]
      end

      g.save
    end
  end

end
