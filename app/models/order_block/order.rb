
module OrderBlock
  class Order < ApplicationRecord
    self.table_name = :order_block_orders
    belongs_to :user, class_name: 'UserBlock::User'
    belongs_to :property, class_name: 'PropertyBlock::Property'
    validates_uniqueness_of :property_id, :scope => :user, :message => 'is already booked for you, Please choose another property'

    after_create :set_prop_status_true
    after_destroy :set_prop_status_false

    def self.ransackable_attributes(auth_object = nil)
      ["currency", "id", "order_id", "property_id", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
    ["property", "user"]
  end

  private 

  def set_prop_status_true
    property = PropertyBlock::Property.find(self.property_id)
    if property
      property.update_column(:is_sold, true)
    end
  end

  def set_prop_status_false
    property = PropertyBlock::Property.find(self.property_id)
    if property
      property.update_column(:is_sold, false)
    end
  end

  end
end
