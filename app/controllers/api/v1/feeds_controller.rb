# frozen_string_literal: true

module Api
  module V1
    class FeedsController < ApplicationController
      def index
        feed_ids = UserFeed.where(user_id: current_user.id).distinct(:feed_id).pluck(:feed_id)
        feeds = Feed.where(id: feed_ids).entries

        render json: feeds, each_serializer: FeedSerializer
      end

      def create
        feed_manager = Feeds::Manager.new(user_id: current_user.id)
        add_result = feed_manager.add_feed(params[:feed_url])
        if add_result[:success]
          # add async task for load feed data
          render json: add_result[:resource].feed, status: 201, serializer: FeedSerializer
        else
          render json: add_result[:errors], status: 422
        end
      end

      def destroy
        contract = Schemas::Api::V1::DestroyFeed.new
        result = contract.call(id: params[:id].to_i)
        if result.errors.empty?
          current_user.user_feeds.where(feed_id: result.to_h[:id]).first.destroy
        else
          render json: result.errors.to_h, status: 422
        end
      end
    end
  end
end
