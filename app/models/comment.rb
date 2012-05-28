class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id

  belongs_to :micropost
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
