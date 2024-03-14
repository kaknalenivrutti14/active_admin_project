# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "heading" do
      h1 "Welcome To Admin Dashboard"
    end

    
    columns do
      column do
        div class: "b1" do 
          div class: "d1" do 
            panel "User List" do
              ul do
                UserBlock::User.all.each do |user|
                  li link_to(user.name, admin_user_path(user))
                end
                h5 "Total User: #{UserBlock::User.count}"
              end
            end
          end
          div class: "d2" do 
            panel "Property List" do
              ul do
                PropertyBlock::Property.all.each do |prop|
                  li link_to(prop.property_name, admin_property_path(prop))
                end
                h5 "Total Property: #{PropertyBlock::Property.count}"
              end
            end
          end
          div class: "d3" do 
            panel "Order List" do
              ul do
                OrderBlock::Order.all.each do |order|
                  li link_to(order.order_id, admin_order_path(order))
                end
                h5 "Total Order: #{OrderBlock::Order.count}"
              end
            end
          end
        end

        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
