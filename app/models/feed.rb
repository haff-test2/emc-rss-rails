# frozen_string_literal: true

class Feed < ApplicationRecord
  enum state: { enabled: 0, disabled: 1 }

  before_validation :ensure_state_exists, on: :create

  validates :url, :state, presence: true

  private

  def ensure_state_exists
    self.state ||= :enabled
  end
end
