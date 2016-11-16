class YankeeScore::Game
  attr_accessor :home_team,
                :away_team,
                :start_time,
                :status,
                :inning,
                :inning_state,
                :score

  PRE_GAME_STATE = ["Pre-Game","Preview", "Warmup"]
  END_GAME_STATE = ["Final", "Postponed", "Game Over"]

  def initialize(home_team, away_team)
    @home_team = home_team
    @away_team = away_team
  end

  @@all ||= []

  def self.all
    @@all
  end

  def self.reset_all!
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create_from_json(game_hash)
      game = self.new(YankeeScore::Team.new(game_hash[:home_name_abbrev]), YankeeScore::Team.new(game_hash[:away_name_abbrev]))

      game.start_time = game_hash[:time]
      game.status = game_hash[:status][:status]
      game.inning = game_hash[:status][:inning]
      game.inning_state = game_hash[:status][:inning_state]


      if game_hash.has_key?(:linescore)
        game.home_team.runs = game_hash[:linescore][:r][:home]
        game.away_team.runs = game_hash[:linescore][:r][:away]
        game.score = "#{game.away_team.runs}-#{game.home_team.runs}"
      end

      game.save
  end


  def self.find_team_by_abbrev(team_abbrev)
    self.all.select do |team|
      team_abbrev == team.home_team.name || team_abbrev == team.away_team.name
    end
  end

  def is_over?
    END_GAME_STATE.include?(self.status)
  end

  def is_active?
    self.inning.to_i >= 1 && !is_over? && !PRE_GAME_STATE.include?(status)
  end
end
