class User < ActiveRecord::Base
  attr_accessible :email, :login, :password

  has_many :microposts, :dependent => :destroy

  has_many :relationships, 
    :foreign_key => "follower_id",
    :dependent => :destroy
  has_many :reverse_relationships, 
    :foreign_key => "followed_id", 
    :class_name => 'Relationship',
    :dependent => :destroy
  
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

  def followers_microposts
    followers_id_relation = Relationship.select('follower_id').where(:followed_id => self.id)
    followers_id = followers_id_relation.map do |user|
       user.follower_id
    end

    Micropost.where("user_id IN (#{followers_id.join(', ')}) OR user_id = #{self.id}").order("created_at DESC")
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
