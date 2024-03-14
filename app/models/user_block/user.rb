module UserBlock
 class User < ApplicationRecord
    self.table_name = :user_block_users

    has_secure_password
    has_one_attached :profile_pic

    has_many :properties, class_name: 'PropertyBlock::Property'
    has_many :orders, class_name: 'OrderBlock::Order'
    has_many :favorite_properties, class_name: 'FavoriteBlock::Favorite'
    has_many :followings, class_name: 'FollowBlock::Follower', foreign_key: 'follower_id'
    has_many :followers, class_name: 'FollowBlock::Follower', foreign_key: 'following_id'
    has_many :ratings, class_name:'RatingBlock::Rating'
    has_one :email_otp, class_name:'UserBlock::EmailOtp'

    validates :name, presence:true
    validates :email, presence:true
    validates :password, presence: true, length: {in: 6..14 }


    def self.ransackable_associations(auth_object = nil)
      ["orders", "properties"]
    end

    def self.ransackable_attributes(auth_object = nil)
      [ "email", "id", "name"]
    end
  end
end
