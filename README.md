Chatterbox
==========

Chatterbox is a small multi-room chat website built with Ruby on Rails and [Faye][faye] (using the [PrivatePub gem][privatepub] by Ryan Bates).

Getting it Running
------------------

Chatterbox has three major parts:

 1. The Rails application
 2. The Faye server
 3. The MongoDB chat log

### The Rails Application

The Rails app is a standard Rails 3 application. Just `bundle install`, `rake db:schema:laod`, and `rails server` and you should be up and running.

### The Faye Server

Faye handles pub/sub for the app, along with the [PrivatePub][privatepub] extension. `faye.ru` is already set up to create a server for you; start it with

    rackup faye.ru -s thin -E production

Note: Faye currently requires thin, and its environment must be set to `production` (this is the `RACK_ENV` variable internally, not the `RAILS_ENV`).

You can configure Faye/PrivatePub using `config/private_pub.yml`. There is a sample for you to work off at `config/private_pub.yml.example`. Be sure to choose a good secret token!

If `config/private_pub.yml` does not exist, `faye.ru` will use the values in `ENV["PP_SERVER"]` and `ENV["PP_TOKEN"]` for the server and token to use, respectively.

### The MongoDB Chat Log

Chats and events are collected into a MongoDB collection. The app uses the values in the following environment variables to connect to a MongoDB database:

    ENV["MONGO_HOST"] = "mongo.db.host"
    ENV["MONGO_PORT"] = "12345"
    ENV["MONGO_DB"]   = "database_name"

Additionally, if your connection requies a username and password, you may set these environment variables as well:

    ENV["MONGO_USER"] = "mongo_user"
    ENV["MONGO_PASS"] = "mongo_password"

You need to create a collection called `chatlogs` in your database (using a capped collection works great for Chatterbox's purposes).

The Future
----------

Expect some improvements as time permits. Specifically:

 * A list of users currently in a room, along with active/idle status
 * Rooms get deleted after they are empty for a certain amount of time
 * Able to change room settings after creation
 * Third-party auth that doesn't crash MRI
 * Maybe even an API!?

  [faye]: http://faye.jcoglan.com/
  [privatepub]: http://github.com/ryanb/private_pub