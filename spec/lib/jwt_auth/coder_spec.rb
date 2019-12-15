# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtAuth::Coder do
  describe '#encode' do
    subject { described_class.new.encode(token) }

    let(:base_time) { Time.current.to_i }
    let(:token) { JwtAuth::Token.new(12, base_time + 4) }

    # TODO: add produced string checking
    it { expect(subject.expire_at).to eq base_time + 4 }
  end

  describe '#decode' do
    let(:base_token_str) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwiZXhwaXJlX2F0IjoxNTc2NDExMjYzfQ._tPcdP7Tm4PRRtM5dZHYLoO4zJE_XLpemvQ6plknMOU' }
    subject { described_class.new.decode(base_token_str) }

    it { expect(subject).to be_a JwtAuth::Token }
    it { expect(subject.expire_at).to eq 1_576_411_263 }
    it { expect(subject.user_id).to eq 12 }
  end
end
