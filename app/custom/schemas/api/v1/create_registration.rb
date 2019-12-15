module Schemas
  module Api
    module V1
      class CreateRegistration < Dry::Validation::Contract
        json do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end

        rule(:email) do
          unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule(:password) do
          if value.length < 6
            key.failure 'too short'
          end
        end
      end
    end
  end
end
