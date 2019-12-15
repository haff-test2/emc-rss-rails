# frozen_string_literal: true

class UserFeed < ApplicationRecord
  belongs_to :user
  belongs_to :feed
end
