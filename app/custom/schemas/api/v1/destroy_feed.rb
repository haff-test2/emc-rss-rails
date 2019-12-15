# frozen_string_literal: true

module Schemas
  module Api
    module V1
      class DestroyFeed < Dry::Validation::Contract
        json do
          required(:id).filled(:integer)
        end

        rule(:id) do
          key.failure 'must be valid id' unless value.positive?
        end
      end
    end
  end
end
