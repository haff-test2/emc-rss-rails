module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_from_token!

      def create
        res = Schemas::Api::V1::CreateRegistration.new.call(params.to_unsafe_h)
        byebug

        if res.errors.present?
          render json: res.errors.to_h, status: 400
          return
        end

        user = User.find_by(email: res.to_h[:email])

        if user&.authenticate(res.to_h[:password])
          new_token = JwtAuth::Token.new(user.id, (Time.current + 4.hour).to_i)
          encoded = JwtAuth::Coder.new.encode(new_token)
          render json: { token: encoded.token_str, exp: encoded.expire_at }, status: 201
        else
          render json: {}, status: 401
        end
      end
    end
  end
end
