
module PropertyBlock

class Property < ApplicationRecord
  self.table_name = :property_block_properties
  has_many :orders, class_name: 'OrderBlock::Order'
  has_many :favorites, class_name: 'FavoriteBlock::Favorite'
  has_many :ratings, class_name: 'RatingBlock::Rating'
  belongs_to :user, class_name: 'UserBlock::User'


  validates_presence_of :property_name, :message => "can't be blank, Please fill the property name"
  validates_uniqueness_of :property_name, :message => 'is already taken, Please take another name'
  validates_presence_of :size, :message => "can't be blank, please fill the property size"
  validates_presence_of :location, :message => "can't be blank, please fill the address of property"


  def self.ransackable_attributes(auth_object = nil)
    ["cost", "created_at", "id", "location", "property_name", "size", "updated_at"]
  end

  def average_rating
      ratings.average(:value)
  end
end

end
