module MongoChat
  class << self
    def connect(host, port, db, user, pass)
      @host = host
      @port = port.to_i
      @db   = db
      @user = user
      @pass = pass

      @db = Mongo::Connection.new(@host, @port).db(@db)
      @db.authenticate(@user, @pass)
    end

    def reconnect
      @db.connection.reconnect
    end

    def chat_logs
      begin
        @logs ||= @db.collection("chatlogs")
      rescue Mongo::ConnectionFailure
        MongoChat.reconnect
        retry
      end
      @logs
    end
  end
end
