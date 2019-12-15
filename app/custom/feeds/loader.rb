# frozen_string_literal: true

module Feeds
  class Loader
    def initialize(feed)
      @feed = feed
    end

    def call
      resp = Faraday.get @feed.url
      # TODO: calc fails and disable feed on multiple failures
      return false unless resp.success?

      feed = RSS::Parser.parse(resp.body)
      chan_title = feed.channel.title
      if chan_title && @feed.channel_title.blank?
        @feed.update(channel_title: chan_title)
      end

      feed.items.each { |item| push_post(item) }
    end

    private

    def push_post(item)
      post = FeedPost.where(
        feed_id: @feed.id,
        published_at: item.pubDate
      ).first_or_initialize do |el|
        el.link = item.link
        el.description = item.description
      end
      post.save
    end
  end
end
