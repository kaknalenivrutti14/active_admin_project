ActiveAdmin.register OrderBlock::Order, as: "Order" do
 
  permit_params :order_id, :currency, :user_id, :property_id
   
  index do
    id_column
    column :order_id 
    column :user  do |order|
      if order&.user&.name.present?
        link_to order.user.name, admin_user_path(order.user.id)
      else
        "user not found"
      end
    end
    column :property_id
    column :currency
    actions
  end

  form do |f|
    f.inputs do
    f.input :user, as: :select, collection: UserBlock::User.all.map{|user| [user.name, user.id]}
    f.input :currency
    f.input :property, as: :select, collection: PropertyBlock::Property.all.map{|prop| [prop.property_name, prop.id]}
  end
    f.actions
  end



  show do
    attributes_table do
      row :user
      row :property do |order|
        if order&.property&.present&.property_name.present?
          link_to order.property.property_name, admin_property_path(order.property.id)
        else
          "user not found"
        end
      end
      row :currency
      row :created_at
    end
  end
end
