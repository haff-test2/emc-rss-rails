# frozen_string_literal: true

class FeedSerializer < ActiveModel::Serializer
  attributes :id, :url, :channel_title
end
