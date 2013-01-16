module JrubyMahout
  class RedisCache
    attr_accessor :on, :redis, :prefix

    def initialize(redis, on, prefix)
      @redis = redis
      @on = on
      @prefix = prefix
    end

    def on?
      @on
    end

    def off?
      !@on
    end

    def empty!(value, params)
      params_string = ""
      params.each do |key, val|
        params_string += "-#{key}:#{val}"
      end
      @redis.del("#{@prefix}-#{value}#{params_string}")
    end
  end
end