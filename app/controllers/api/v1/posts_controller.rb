# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        feed_ids = Feeds::Manager.new(user_id: current_user.id).sync
        posts = FeedPost.where(feed_id: feed_ids).order(published_at: :desc).limit(10)

        render json: posts, status: 200, serialiaer: PostSerializer
      end
    end
  end
end
