module MongoChat
  class << self
    def connect(host, port, db, user, pass)
      @host = host
      @port = port.to_i
      @db   = db
      @user = user
      @pass = pass

      @connection = Mongo::Connection.new(@host, @port).db(@db)
      @connection.authenticate(@user, @pass)
    end

    def reconnect
      @connection.reconnect
    end

    def chat_logs
      begin
        @logs ||= @connection.collection("chatlogs")
      rescue Mongo::ConnectionFailure
        MongoChat.reconnect
        retry
      end
      @logs
    end
  end
end
