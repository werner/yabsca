class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :login, :password
  validates_uniqueness_of :login

  def self.authenticate(login, password)
    find_by_login(login).try(:authenticate, password)
  end

end
