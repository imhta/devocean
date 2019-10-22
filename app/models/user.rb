# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes

  has_many :friendships, dependent: :destroy
  has_many :friends,
           -> { where friendships: { status: 'accepted' } }, through: :friendships
  has_many :pending_friends,
           -> { where friendships: { status: 'pending' } }, through: :friendships, source: :friend
  has_many :requested_friends,
           -> { where friendships: { status: 'requested' } }, through: :friendships, source: :friend

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

  def friend_request(friend)
    friendships.create(friend: friend, status: 'pending')
    friend.friendships.create(friend: self, status: 'requested')
  end

  def accept(friend)
    relations(friend).each { |friendship| friendship.update(status: 'accepted') }
  end

  def relations(friend)
    Friendship.where(user: self, friend: friend) + Friendship.where(user: friend, friend: self)
  end

  def friend_with?(friend)
    Friendship.where(user: self, friend: friend, status: 'accepted').any?
  end

  def decline_request(friend)
    relations(friend).each(&:destroy)
  end

  def strangers
    User.all - [self] - friends - pending_friends - requested_friends
  end
end
