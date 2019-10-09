# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:post)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end