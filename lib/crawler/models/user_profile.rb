require_relative "safe_insertable"
require_relative "fetchable"
require_relative "mapping"
require_relative "../logging"


module Crawler
  module Models
    class UserProfile < ActiveRecord::Base
      include Crawler::Logging

      extend Fetchable
      fetcher :users_get, :uids, Mapping.user_profile
      MAX_PROFILES_PER_FETCH = 100

      extend SafeInsertable
      unique_id :vk_id

      validates_uniqueness_of :vk_id

      has_many :posts, primary_key: "vk_id", foreign_key: "owner_id"
      has_many :primary_friendships, :class_name => "Friendship", :foreign_key => "user_profile_id", dependent: :destroy
      has_many :primary_friends, through: :primary_friendships, :source => :friend
      has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
      has_many :inverse_friends, :through => :inverse_friendships, :source => :user_profile

      has_many :likes, dependent: :destroy
      has_many :likes_posts, through: :likes, source: "post"

      def friends
        primary_friends + inverse_friends
      end

      def self.load_or_fetch(id)
        ids = id.is_a?(Array) ? id : [id]
        models = UserProfile.where(vk_id: ids).to_a
        existing = models.map(&:vk_id)
        new = ids - existing
        ((new.count-1) / MAX_PROFILES_PER_FETCH + 1).times do |i|
          ids_to_fetch = new[i*MAX_PROFILES_PER_FETCH..(i+1)*MAX_PROFILES_PER_FETCH - 1]
          fetched = UserProfile.fetch(ids_to_fetch)
          fetched = [fetched] unless fetched.is_a?(Array)
          models += fetched
        end
        models
      end

      def fetch_friends
        ids = Friendship.fetch(vk_id).map(&:user_profile_id)
        users = self.class.load_or_fetch(ids)
        users -= inverse_friends
        inserted_users = self.class.insert(users)
        friendships = inserted_users.map { |user| Friendship.new user_profile_id: self.id, friend_id: user.id}
        Friendship.insert(friendships)
        inserted_users
      end

    end
  end
end
