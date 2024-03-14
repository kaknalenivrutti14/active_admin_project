ActiveAdmin.register RatingBlock::Rating, as: "Rating" do

  # menu label:"Property"

  permit_params :property_id, :user_id, :value

  index do
    id_column
    column :property do |rating|
     if rating.property.present?
        link_to rating.property.property_name, admin_property_path(rating.property_id)
     else
        "property not found"
     end
    end

    column :value 
    column :user  do |rating|
      if rating&.user&.present?
        link_to rating.user.name, admin_user_path(rating.user.id)
      else
        "user not found"
      end
    end
    actions
  end
end
