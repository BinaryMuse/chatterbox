class Room < ActiveRecord::Base
  attr_accessible :name, :password
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => true
  before_validation :generate_name, :encrypt_password

  def has_password?(password)
    encrypt(password) == self.password
  end

  def to_param
    name
  end

  private

    def generate_name
      self.name = ActiveSupport::SecureRandom.hex(6) if name.blank?
    end

    def encrypt_password
      self.password = encrypt(password) unless password.blank?
    end

    def encrypt(text)
      Digest::SHA2.hexdigest(text)
    end
end
