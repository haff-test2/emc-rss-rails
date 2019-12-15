# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url, null: false
      t.string :channel_title
      t.integer :state, null: false

      t.timestamps
    end

    add_index :feeds, :url
  end
end
