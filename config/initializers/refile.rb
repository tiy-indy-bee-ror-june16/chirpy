require "refile"
Refile.configure do |config|
  connection = lambda { |&blk| ActiveRecord::Base.connection_pool.with_connection { |con| blk.call(con.raw_connection) } }
  config.store = Refile::Postgres::Backend.new(connection)
end

if Rails.env.production?
  Refile.cdn_host = 'https://serene-basin-53447.herokuapp.com'
else
  Refile.cdn_host = 'http://localhost:3000'
end
