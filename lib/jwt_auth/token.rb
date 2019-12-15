module JwtAuth
  class Token
    attr_reader :user_id, :expire_at

    def initialize(user_id, expire_at)
      @user_id = user_id
      @expire_at = expire_at
    end

    def to_h
      {
        user_id: @user_id,
        expire_at: @expire_at
      }
    end

    def expired?
      self.expire_on?(Time.current.to_i)
    end

    def expire_on?(timestamp)
      @expire_at < timestamp
    end
  end
end
