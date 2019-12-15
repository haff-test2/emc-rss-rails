# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schemas::Api::V1::DestroyFeed do
  subject { described_class.new.call(id: context_id) }

  context 'id is not num' do
    let(:context_id) { '2' }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:id) }
  end

  context 'id is zero' do
    let(:context_id) { 0 }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:id) }
  end

  context 'id is valid' do
    let(:context_id) { 2 }

    it { expect(subject.errors).to be_empty }
  end
end
