class Vote < ActiveRecord::Base

  validates_uniqueness_of :video_id, source: :user_id

  belongs_to :user
  belongs_to :video
end
