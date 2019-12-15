require 'rails_helper'

RSpec.describe Feeds::Loader do
  let(:feed) { create(:feed, url: 'http://www.ruby-lang.org/en/feeds/news.rss' ) }
  let(:feed_post_1) { create(:feed_post, feed_id: feed.id) }

  let(:service) { described_class.new(feed) }

  describe '#call', vcr: { cassette_name: 'feeds/loader/base' } do
    before do
      feed
      feed_post_1
    end

    subject { service.call }

    it { expect { subject }.to change { feed.channel_title }.from(nil).to('Ruby News') }
    it { expect { subject }.to change { FeedPost.where(feed_id: feed.id).count }.from(1).to(5) }
  end
end
