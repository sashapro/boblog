class Micropost < ActiveRecord::Base
  attr_accessible :content, :image

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 340 }
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

  has_attached_file :image,
                    :styles => { :medium => "640x450>" }

  validates_attachment :image,
                       :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/jpg'] },
                       :size => { :less_than => 3.megabytes }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end