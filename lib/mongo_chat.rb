module MongoChat
  class << self
    def connect(host, port, db, user = nil, pass = nil)
      @host = host
      @port = port.to_i
      @db   = db
      @user = user
      @pass = pass

      @db = Mongo::Connection.new(@host, @port).db(@db)
      @db.authenticate(@user, @pass) if @user and @pass
    end

    def reconnect
      @db.connection.reconnect
    end

    def chat_logs
      @logs ||= @db.collection("chatlogs")
    end

    def log(hash)
      begin
        chat_logs.insert(hash)
      rescue Mongo::ConnectionFailure
        reconnect
        retry
      end
    end

    def log_chat(id, name, room_sha1, message)
      log({
        "user_id" => id, "username" => name,
        "room_sha1" => room_sha1, "message" => message
      })
    end

    def log_event(id, name, room_sha1, event)
      log({
        "user_id" => id, "username" => name,
        "room_sha1" => room_sha1, "event" => event
      })
    end

    def recent_chats(room_sha1)
      begin
        chats = []
        chat_logs.find("room_sha1" => room_sha1).sort('$natural', -1).limit(15).each do |row|
          chats << {
            :user_id  => row["user_id"],
            :username => row["username"],
            :message  => row["message"] || nil,
            :event    => row["event"] || nil
          }
        end
      rescue Mongo::ConnectionFailure
        reconnect
        retry
      end
      chats.reverse
    end
  end
end
