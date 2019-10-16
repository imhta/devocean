# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self

  private

  # def create_inverse_relationship
  #   friend.friendships.create(friend: user)
  # end

  # def destroy_inverse_relationship
  #   friendship = friend.friendships.find_by(friend: user)
  #   friendship&.destroy
  # end

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
  end
  
end
