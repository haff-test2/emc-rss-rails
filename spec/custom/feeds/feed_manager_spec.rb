require 'rails_helper'

RSpec.describe Feeds::Manager do
  let(:service) { described_class.new(user_id: context_user_id, feed_ids: context_feed_ids) }
  let(:user) { create(:user) }

  describe '#add_feed' do
    let(:new_url_str) { 'http://new_feed_url.com' }
    subject { service.add_feed(new_url_str) }

    context 'if user_id nil' do
      let(:context_user_id) { nil }
      let(:context_feed_ids) { [] }

      it { expect(subject).to be_a FalseClass }
    end

    context 'when user_id present' do
      let(:context_user_id) { user.id }
      let(:context_feed_ids) { [] }

      context 'when feed for user already registered' do
        let!(:feed) { create(:feed, url: new_url_str) }
        let!(:user_feed) { create(:user_feed, feed: feed, user: user) }

        it { expect(subject[:success]).to be_a TrueClass }
        it { expect { subject }.not_to change { Feed.count } }
        it { expect { subject }.not_to change { UserFeed.count } }
      end

      context 'feed exists, not registered for user' do
        let!(:feed) { create(:feed, url: new_url_str) }

        it { expect(subject[:success]).to be_a TrueClass }
        it { expect { subject }.not_to change { Feed.count } }
        it { expect { subject }.to change { UserFeed.count }.by 1 }
      end

      context 'for new feed' do
        it { expect(subject[:success]).to be_a TrueClass }
        it { expect { subject }.to change { Feed.count }.by 1 }
        it { expect { subject }.to change { UserFeed.count }.by 1 }
        it do
          subject
          feed = Feed.find_by(url: new_url_str)
          expect(UserFeed.where(feed: feed, user: user)).to be_present
        end
      end
    end
  end

  describe '#sync' do
    subject { service.sync }
    let(:user_2) { create(:user) }
    let(:feed_1) { create(:feed, url: 'f1_url') }
    let(:feed_2) { create(:feed, url: 'f2_url') }
    let(:feed_3) { create(:feed, url: 'f3_url') }
    let(:feed_4) { create(:feed, url: 'f3_url') }
    let(:user_feed_1) { create(:user_feed, user: user, feed: feed_1) }
    let(:user_feed_3) { create(:user_feed, user: user, feed: feed_3) }
    let(:user_2_feed_1) { create(:user_feed, user: user_2, feed: feed_2) }

    before do
      allow(Thread).to receive(:new).and_return(nil)

      user_2
      feed_1
      feed_2
      feed_3
      feed_4
      user_feed_1
      user_feed_3
      user_2_feed_1
    end

    context 'user_id only' do
      let(:context_user_id) { user.id }
      let(:context_feed_ids) { [] }

      it { expect(subject).to match_array [feed_1.id, feed_3.id] }
    end

    context 'feed_ids only' do
      let(:context_user_id) { nil }
      let(:context_feed_ids) { [feed_1.id, feed_2.id, feed_3.id, feed_4.id] }

      it { expect(subject).to match_array [feed_1.id, feed_2.id, feed_3.id] }
    end

    context 'feed_ids and user_id passed' do
      let(:context_user_id) { user.id }
      let(:context_feed_ids) { [feed_1.id, feed_2.id] }

      it { expect(subject).to match_array [feed_1.id] }
    end
  end
end
