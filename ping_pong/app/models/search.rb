class Search

  def self.for(player)
    Player.where("lower(name) like ?", "%#{player}%".downcase)
  end
  # good - don't be afraid to have small classes

end