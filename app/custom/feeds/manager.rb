# frozen_string_literal: true

module Feeds
  class Manager
    def initialize(user_id: nil, feed_ids: [])
      @user_id = user_id
      @feed_ids = feed_ids
    end

    def add_feed(url)
      return false if @user_id.nil?

      feed = Feed.where(url: url).first_or_create
      new_feed = UserFeed.where(user_id: @user_id, feed: feed).first_or_initialize
      { success: new_feed.save, errors: new_feed.errors.messages, resource: new_feed }
    end

    # TODO: add perform_async option and run by cron/new_feeds_event
    # with last update time control
    def sync
      query_ids = context_enabled_feeds
      return [] if query_ids.blank?

      feeds = Feed.where(id: query_ids).entries
      feed_threads = []
      feeds.each do |feed|
        Thread.new { Feeds::Loader.new(feed).call }
      end

      feed_threads.each(&:join)
      query_ids
    end

    private

    def context_enabled_feeds
      q = UserFeed.all
      q = q.where(feed_id: @feed_ids) if @feed_ids.present?
      q = q.where(user_id: @user_id) if @user_id.present?
      q.pluck(:feed_id)
    end
  end
end
