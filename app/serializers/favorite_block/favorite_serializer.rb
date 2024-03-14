class FavoriteBlock::FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attributes :property do |object| 
    PropertyBlock::Property.find(object.property_id)

  end
end
