# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends,
           -> { where friendships: { status: 'accepted' } }, through: :friendships
  has_many :pending_friends,
           -> { where friendships: { status: 'pending' } }, through: :friendships, source: :friend
  has_many :requested_friends,
           -> { where friendships: { status: 'requested' } }, through: :friendships, source: :friend
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.img_link = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def display_name
    first_name + ' ' + last_name
  end

  def initial
    first_name[0].upcase
  end

  def my_timeline_posts
    Post.where(user_id: self).or(Post.where(user_id: friends))
  end

  def friend_request(friend)
    friendships.create(friend: friend, status: 'pending')
    friend.friendships.create(friend: self, status: 'requested')
  end

  def accept(friend)
    pending_relations(friend).each { |friendship| friendship.update(status: 'accepted') }
  end

  def pending_relations(friend)
    Friendship.where(user: self, friend: friend) + Friendship.where(user: friend, friend: self)
  end

  def relations(friend)
    Friendship.where(user: self,
                     friend: friend,
                     status: 'accepted') + Friendship.where(user: friend,
                                                            friend: self,
                                                            status: 'accepted')
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
