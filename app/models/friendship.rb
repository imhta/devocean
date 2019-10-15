class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  enum status: [:0, :1, :2]

  private

  def create_request
    friend.friendship.create(friend: user, status: :1) if status.zero?
  end


end
