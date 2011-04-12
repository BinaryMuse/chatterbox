require 'mongo_chat'

MongoChat.connect(ENV["MONGO_HOST"], ENV["MONGO_PORT"], ENV["MONGO_DB"], ENV["MONGO_USER"] || nil, ENV["MONGO_PASS"] || nil)
