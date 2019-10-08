# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def display_name
    first_name + ' ' + last_name
  end

  def initial
    first_name[0].upcase
  end
end
