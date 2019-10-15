# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  scope :desc, -> { order('created_at DESC') }
end
