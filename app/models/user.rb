class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :name, :email, :password, :password_confirmation,
                  :remember_me, :avatar, :born_on, :female, :status,
                  :about, :admin, :nik, :surname

  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_attached_file :avatar,
                    :default_url => "/assets/missing_:style.jpg" ,
                    :styles => { :medium => "200x400>", :thumb => "100x100>" }

  validates_attachment :avatar,
                       :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/jpg'] },
                       :size => { :less_than => 3.megabytes }


  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
