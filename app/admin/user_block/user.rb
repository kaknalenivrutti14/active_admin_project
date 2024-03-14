ActiveAdmin.register UserBlock::User, as: "User" do

  # menu label:"User"
# config.filters = false
  permit_params :name, :email, :password_digest, :profile_pic

 index do
    # selectable_column disabled: true
    id_column
    column :email
    column :name
    column :profile_pic do |user|
        if user.profile_pic.attached?
          image_tag(url_for(user.profile_pic), style: 'width:50px; height: 50px;border-radius: 50%;')
        else
          "profile pic not attached"
        end
    end
    actions
  end

  filter :email
  filter :name

  form do |f|
    f.inputs do
    f.input :name
    f.input :email
    f.input :profile_pic, as: :file
    f.input :password_digest
  end
    f.actions
  end


show do
  attributes_table do
    row :profile_pic do |user|
      user.profile_pic.attached? ? image_tag(url_for(user.profile_pic),style: 'border-radius: 50%; height: 200px; width: 200px;'):"profile pic not found"
    end
    row :name
    row :email
  end

  panel "Followers" do
    table_for(user.followers) do
      if user.followers.present?
        column :follower_username do |fr_user|
          link_to fr_user.follower.name.capitalize, admin_user_path(fr_user.follower.id)
        end

        column :follower_profile_pic do |user|
          user.follower.profile_pic.attached? ? image_tag(url_for(user.follower.profile_pic),style: 'border-radius: 50%; height: 50px; width: 50px;'):"profile pic not found"
        end
      else
        para "No followers found."
      end
    end
  end

  panel "Followings" do
    table_for(user.followings) do
      if user.followings.present?
        column :following_username do |fg_user|
          link_to fg_user.following.name.capitalize, admin_user_path(fg_user.following_id)
        end
        column :follower_profile_pic do |user|
          user.following.profile_pic.attached? ? image_tag(url_for(user.following.profile_pic),style: 'border-radius: 50%; height: 50px; width: 50px;'):"profile pic not found"
        end
      else
        para "No followings found."
      end
    end
  end

  panel "Favorite Property" do
    table_for(user.favorite_properties) do
      if user.favorite_properties.present?
        column :property_name do |p_name|
          link_to p_name.property.property_name, admin_property_path(p_name.property.id)
        end
        column :average_rating do |p_name|
          p_name.property.ratings.average(:value)||0.0
        end
      else
        para "No property found."
      end
    end
  end

  panel "Property Rated List" do
    table_for(user.ratings) do
      if user.ratings.present?
        column :property_name do |rating|
          link_to rating.property.property_name, admin_property_path(rating.property_id)
        end
        column :rating_value do |rating|
          rating.value
        end
      else
        para "No property Rated found."
      end
    end
  end
end
  

end

