# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  has_may :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
