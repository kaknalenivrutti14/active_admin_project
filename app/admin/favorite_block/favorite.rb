ActiveAdmin.register FavoriteBlock::Favorite, as: "FavoriteProperty" do

  
    permit_params :user_id, :property_id

    remove_filter :user
    remove_filter :property
    remove_filter :created_at
    remove_filter :updated_at

index do
    # selectable_column disabled: true
    id_column
    column :user
    column :property do |favorite|
      if favorite.property.present?
        favorite.property.property_name
      else
        "property not found"
      end
    end
    actions
  end

  show do 
    attributes_table do 
      row :user
      row :property do |favorite|
        if favorite.property.present?
          favorite.property.property_name
        else
          "property not found"
        end
      end
    end
  end

end
