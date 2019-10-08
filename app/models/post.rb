# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_rich_text :body
  validates :body, presence: true
end
