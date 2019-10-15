# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self

  # enum status: [:0, :1, :2]

  private

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship&.destroy
  end

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
  # def create_request
  #   friend.friendship.create(friend: user, status: :1) if status.zero?
  # end
end
