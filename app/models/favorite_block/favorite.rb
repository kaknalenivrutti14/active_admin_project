 module FavoriteBlock
  
  class Favorite < ApplicationRecord
    self.table_name = :favorite_block_favorites
    belongs_to :user, class_name: 'UserBlock::User'
    belongs_to :property, class_name: 'PropertyBlock::Property'

    validates_uniqueness_of :property_id, :scope => :user, :message => 'This property is already in your favorite list' 
 
    def self.ransackable_associations(auth_object = nil)
      ["property", "user"]
    end

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "property_id", "updated_at", "user_id"]
    end
  end
end
