class Room < ActiveRecord::Base
  attr_accessible :name, :password
  validates_presence_of   :name
  validates_uniqueness_of :name, :case_sensitive => true

  before_validation :generate_name, :encrypt_password
  before_save       :generate_sha1

  def has_password?(password)
    encrypt(password) == self.password
  end

  def to_param
    sha1
  end

  def log_message(user, message)
    begin
      MongoChat.chat_logs.insert({
        "user_id" => user.id, "username" => user.username || user.email,
        "room_sha1" => sha1, "message" => message
      })
    rescue Mongo::ConnectionFailure
      MongoChat.reconnect
      retry
    end
  end

  def log_event(user, event)
    begin
      MongoChat.chat_logs.insert({
        "user_id" => user.id, "username" => user.username || user.email,
        "room_sha1" => sha1, "event" => event.to_s
      })
    rescue Mongo::ConnectionFailure
      MongoChat.reconnect
      retry
    end
  end

  def recent_chats
    begin
      chats = []
      MongoChat.chat_logs.find("room_sha1" => sha1).sort('$natural', -1).limit(15).each do |row|
        chats << {
          :user_id  => row["user_id"],
          :username => row["username"],
          :message  => row["message"] || nil,
          :event    => row["event"] || nil
        }
      end
    rescue Mongo::ConnectionFailure
      MongoChat.reconnect
      retry
    end
    chats.reverse
  end

  private

    def generate_name
      self.name = ActiveSupport::SecureRandom.hex(6) if name.blank?
    end

    def generate_sha1
      self.sha1 = Digest::SHA1.hexdigest(name)
    end

    def encrypt_password
      self.password = encrypt(password) unless password.blank?
    end

    def encrypt(text)
      Digest::SHA2.hexdigest(text)
    end
end
