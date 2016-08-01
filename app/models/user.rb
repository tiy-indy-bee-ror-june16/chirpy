class User < ApplicationRecord

  has_secure_password
  acts_as_follower
  acts_as_followable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :auth_token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  has_many :posts, dependent: :destroy

  def chirps
    ids = followees(User, pluck: :id) << id
    Post.where(user_id: ids)
  end

  def following_count
    followees_count
  end

  def chirp_count
    posts.count
  end

  def avatar
    self[:avatar] ? self[:avatar] : "https://robohash.org/sdgerhre.png"
  end

  def self.find_for_auth(value)
    find_by(username: value) || find_by(email: value)
  end


  private

  def generate_token
    while auth_token.blank? || User.exists?(auth_token: auth_token)
      self.auth_token = SecureRandom.hex(10)
    end
  end

end
