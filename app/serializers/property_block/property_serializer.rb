class PropertyBlock::PropertySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :property_name, :cost, :size, :location, :is_sold

  attribute :avg_rating do |object|
    object.ratings.avg_rating_for_property(object.id)
  end
  
  attribute :is_rated do |object,user|
    user[:current_user].ratings.pluck(:property_id).include?(object.id) if user.present?
  end

  attribute :is_favorite do |object,user|
    user[:current_user].favorite_properties.pluck(:property_id).include?(object.id) if user.present?
  end

end
