# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :gender, presence: true

  def display_name
    first_name + ' ' + last_name
  end

  def initial
    first_name[0].upcase
  end

  # def friends
  #   friends_array = friendships.map{|friendship| friendship.friend if friendship}
  #   friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
  #   friends_array.compact
  # end

  # def friend_request
  #   inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  # end

  # def comfirm_friend(usere)
  #   friendship = inverse_friendships.find{|friendship| friendship.user == user }
  #   friendship.confirmed = true
  #   friendship.save
  # end

  # def friend?(user)
  #   friends.include?(user)
  # end
end
