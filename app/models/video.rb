class Video < ActiveRecord::Base
  belongs_to :playlist
  has_many :votes
  has_many :users, through: :votes
end
