
module RatingBlock
  class Rating < ApplicationRecord
    self.table_name = :rating_block_ratings
    
    belongs_to :user, class_name: 'UserBlock::User'
    belongs_to :property, class_name: 'PropertyBlock::Property'
    validates :value, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Rating value must be between 1 and 5" }
    validates_uniqueness_of :property_id, :scope => :user, :message => 'rating already is done by you'

    def self.avg_rating_for_property(property_id)
      where(property_id: property_id).average(:value)
    end

    def self.ransackable_associations(auth_object = nil)
      ["property", "user"]
    end

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "property_id", "updated_at", "user_id", "value"]
    end

  end
end
