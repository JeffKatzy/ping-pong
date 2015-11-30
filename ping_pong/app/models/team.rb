# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "pry"

class Team < ActiveRecord::Base
  has_many :team_games
  has_many :games, through: :team_games
  # has_many :team_players
  # has_many :players, through: :team_players
  has_and_belongs_to_many :players

  def self.find_or_create_by_player_ids(player_id_array)
    # ok, lets revisit this
    # Player.find(:player1_id).teams.select { |team| TeamPlayer.find_by(player_id: :player2_id, team_id: team.id }
    player1_id = player_id_array[0]
    player2_id = player_id_array[1]
    player1 = Player.find_by(id: player1_id)
    player2 = Player.find_by(id: player2_id)

    if !!player2 && (player1.teams & player2.teams) != []
      team_array = player1.teams & player2.teams
      team_array[0]
    elsif player2_id != 0
      new_team = Team.create
      new_team.player_ids = player_id_array
      new_team.tap(&:save)
    elsif player1.teams.reject { |team| team.players.count != 1 } != []
      player1.teams.reject do |team| 
        team.players.count != 1
      end[0]
    else
      new_team = Team.create
      new_team.players << player1
      new_team.tap(&:save)
    end

  end

  def player_names
    players = self.players
    if players.count > 1
      "#{players[0].name}/#{players[1].name}"
    else
      "#{players[0].name}"
    end
  end
  
end
