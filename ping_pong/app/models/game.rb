# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  match_time :datetime
#  table_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  has_many :team_games, dependent: :destroy
  has_many :teams, through: :team_games
  belongs_to :table
  accepts_nested_attributes_for :teams
  accepts_nested_attributes_for :team_games

  def opponent(team_id)
    self.teams.select do |team|
      team.id != team_id
    end[0]
  end


  # this reveals perhaps improper modeling 
  def find_team_game_by_player_id(id)
    self.team_games.find do |team_game|
      team = self.teams.find do |team|
        team.players.include?(Player.find(id))
      end
      team_game.team_id == team.id
    end
  end

  def team_one
    self.team_games.first.team
  end

  def team_one_score
    self.team_games.first.score
  end

  def team_two
    self.team_games.last.team
  end

  def team_two_score
    self.team_games.last.score
  end

# repetiton here - first find out who is the winning team, 
# and then use that to find their score
  def winning_team
    if team_one_score > team_two_score
      team_one
    else
      team_two
    end
  end

  def losing_team
    if team_one_score > team_two_score
      team_two
    else
      team_one
    end
  end

  def winning_team_score
    if team_one_score > team_two_score
      team_one_score
    else
      team_two_score
    end
  end

  def losing_team_score
    if team_one_score > team_two_score
      team_two_score
    else
      team_one_score
    end
  end
  # why the extra method - name it right the first time
  def start_time
    match_time
  end
end
