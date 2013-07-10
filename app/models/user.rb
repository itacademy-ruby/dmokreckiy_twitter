class User < ActiveRecord::Base
  attr_accessible :email, :login, :password

  has_many :microposts

  validates :login, :length => {:minimum => 5}
  
  before_save :update_password

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
