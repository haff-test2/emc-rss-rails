require 'rails_helper'

RSpec.describe Schemas::Api::V1::CreateRegistration do
  subject { described_class.new.call(email: context_email, password: context_pass) }

  context 'email invalid' do
    let(:context_email) { 'test_eml-domain.com' }
    let(:context_pass) { '123456' }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:email) }
  end

  context 'password is empty' do
    let(:context_email) { 'test_eml@domain.com' }
    let(:context_pass) { '' }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:password) }
  end

  context 'email is empty' do
    let(:context_email) { '' }
    let(:context_pass) { '123456' }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:email) }
  end

  context 'password too short' do
    let(:context_email) { 'test_eml@domain.com' }
    let(:context_pass) { '12345' }

    it { expect(subject.errors).not_to be_empty }
    it { expect(subject.errors.to_h.keys).to include(:password) }
  end

  context 'valid' do
    let(:context_email) { 'test_eml@domain.com' }
    let(:context_pass) { '123456' }

    it { expect(subject.errors).to be_empty }
  end
end
