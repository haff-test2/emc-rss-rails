# frozen_string_literal: true

class CreateFeedPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :feed_posts do |t|
      t.belongs_to :feed
      t.time :published_at
      t.string :link
      t.text :description

      t.timestamps
    end

    add_index :feed_posts, :published_at
  end
end
