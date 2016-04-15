class YankeeScore::ScoreScraper


  @@base_url = "http://gd2.mlb.com/components/game/mlb/"

  def build_url(date = Date.today)
    "#{@@base_url}year_#{date.year}/month_#{date.strftime("%m")}/day_#{date.strftime("%d")}/master_scoreboard.json"
  end

  def data
      uri = URI.parse(self.build_url)
      response = Net::HTTP.get_response(uri)
      @data = response.body
  end


  def json
    @json ||= JSON.parse(data, symbolize_names: true)
  end

  def games
    json[:data][:games][:game]
  end


  def load_games
    games.select do |game_hash|
      YankeeScore::Game.create_from_json(game_hash)
    end
  end

end
