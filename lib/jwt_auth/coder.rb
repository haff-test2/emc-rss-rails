# frozen_string_literal: true

module JwtAuth
  class Coder
    EncodeResult = Struct.new(:token_str, :expire_at)
    SECRET = Rails.application.secrets.secret_key_base

    def decode(token_str)
      payload = JWT.decode(token_str, SECRET).first
      JwtAuth::Token.new(payload['user_id'], payload['expire_at'])
    rescue JWT::VerificationError
    end

    def encode(token)
      unless token.is_a?(JwtAuth::Token)
        raise(ArgumentError, 'JwtAuth::Token expected')
      end

      EncodeResult.new(JWT.encode(token.to_h, SECRET), token.expire_at)
    end
  end
end
