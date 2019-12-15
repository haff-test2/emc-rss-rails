# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :authenticate_from_token!

      def create
        svc = Services::Users::SignUp.new(email: params[:email], password: params[:password])
        if svc.call
          render json: svc.new_user, serializer: UserSerializer, status: 201
        else
          render json: svc.errors, status: 422
        end
      end
    end
  end
end
