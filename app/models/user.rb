class User < ActiveRecord::Base
  attr_accessible :email, :login, :password

  has_many :microposts

  has_many :relationships, 
    :foreign_key => "follower_id"
  has_many :reverse_relationships, 
    :foreign_key => "followed_id", 
    :class_name => 'Relationship'
  
  has_many :followed_users, 
    :through => :relationships, 
    :source => :followed
  has_many :followers, 
    :through => :reverse_relationships, 
    :source => :follower

  validates :login, :length => {:minimum => 5}
  
  before_save :update_password

  def follow!(followed_user)
    relationships.create!(:followed_id => followed_user.id)
  end

  def following?(followed_user)
    self.relationships.find_by_followed_id(followed_user.id).present?
  end

  def unfollow(followed_user)
    relationships.find_by_followed_id(followed_user.id).destroy
  end

  def password_valid?(password)
    self.password == crypt_password(password)
  end

  private

  def update_password
    self.password = crypt_password(self.password)
  end

  def crypt_password(password)
    return 1
    Digest::MD5.hexdigest(password)
  end
end
