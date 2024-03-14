ActiveAdmin.register PropertyBlock::Property, as: "Property" do

  # menu label:"Property"

  permit_params :property_name, :size, :cost, :location, :user_id

  index do
    id_column
    column :property_name 
    column :user  do |property|
      if property&.user&.present?
        link_to property.user.name, admin_user_path(property.user.id)
      else
        "user not found"
      end
    end
    column :size
    column :location
    actions
  end


form do |f|
    f.inputs do
      f.input :user, as: :select, collection: UserBlock::User.all.map{|user| [user.name, user.id]}
      f.input :property_name
      f.input :size
      f.input :cost
      f.input :location
    end
   
    f.actions
   
end
 
filter :cost
filter :property_name
filter :size

  show do
  attributes_table do
    row :property_name
    row :size
    row :cost
    row :location
    row :user
    row :is_sold
    row :avg_rating do |property|
      property.ratings.present? ? property.ratings.average(:value) : 0
    end
  end

  panel "Rating user list" do
    table_for(property.ratings) do
      if property.ratings.present?
        column :user_name do |rating|
          link_to rating.user.name.capitalize, admin_user_path(rating.user_id)
        end
        column :rating_value do |rating|
          rating.value
        end
      else
        para "Rating list not found"
      end
    end
  end
  panel "This Property is favorite for this user list" do
    table_for(property.favorites) do
      if property.favorites.present?
        column :user_name do |favorite|
          link_to favorite.user.name.capitalize, admin_user_path(favorite.user_id)
        end
        column :is_favorite do |favorite|
          favorite.user.present?
        end
      else
        para "Favorite list not found"
      end
    end
  end
 end


end
