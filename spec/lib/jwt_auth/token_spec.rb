# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtAuth::Token do
  let(:context_expire_at) { Time.current.to_i }
  let(:token) { described_class.new(2, context_expire_at) }

  describe '#user_id' do
    it { expect(token.user_id).to eq 2 }
  end

  describe '#expiret_at' do
    it { expect(token.expire_at).to eq context_expire_at }
  end

  describe '#to_h' do
    subject { token.to_h }

    it { expect(subject).to have_key(:user_id) }
    it { expect(subject[:user_id]).to eq 2 }
    it { expect(subject).to have_key(:expire_at) }
    it { expect(subject[:expire_at]).to eq context_expire_at }
  end

  describe '#expire_on' do
    subject { token.expire_on?(context_timestamp) }

    context 'after date' do
      let(:context_timestamp) { context_expire_at + 86_400 }

      it { expect(subject).to be_a TrueClass }
    end

    context 'before date' do
      let(:context_timestamp) { context_expire_at - 86_400 }

      it { expect(subject).to be_a FalseClass }
    end

    context 'same time' do
      let(:context_timestamp) { context_expire_at }

      it { expect(subject).to be_a FalseClass }
    end
  end

  describe '#expired?' do
    subject { token.expired? }

    context 'expired' do
      let(:context_expire_at) { Time.current.to_i - 86_400 }

      it { expect(subject).to be_a TrueClass }
    end

    context 'not expired' do
      let(:context_expire_at) { Time.current.to_i + 86_400 }

      it { expect(subject).to be_a FalseClass }
    end
  end
end
