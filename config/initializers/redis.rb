require "redis"

begin
  REDIS = Redis.new(url: Rails.configuration.redis_url)
rescue Exception => e
  puts e
end
