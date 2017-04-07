require 'bcrypt'
require 'dm-validations'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password_digest, Text
  attr_accessor :password_confirmation

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  attr_reader :password
  validates_confirmation_of :password
  validates_format_of :email, :as => :email_address
  validates_presence_of :email

end
