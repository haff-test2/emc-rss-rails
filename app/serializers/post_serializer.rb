# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  # TODO: xss possible. check if all field sanitized by rss lib.
  attributes :id, :feed_id, :published_at, :link, :description
end
