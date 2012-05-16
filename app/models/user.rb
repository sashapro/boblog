class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar
  has_secure_password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }#,
                    #:url  => "images/:attachment/:id/:style/:filename",
                    #:path => ":rails_root/app/assets/images/:attachment/:id/:style/:filename"

  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create, length: { minimum: 6 }
  validates :password_confirmation, presence: true, on: :create

  validates_attachment :avatar,
                       :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/jpg'] },
                       :size => { :less_than => 3.megabytes }

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end