Redis.current = Redis.new(url:  ENV['REDIS_URL'],
                          port: ENV['REDIS_PORT'],
                          db:   ENV['REDIS_DB'],
                          host: ENV["REDIS_HOST"],
                          port: ENV["REDIS_PORT"],
                          password: ENV['REDIS_PASSWORD'])