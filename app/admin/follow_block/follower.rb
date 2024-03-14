ActiveAdmin.register FollowBlock::Follower, as: "Follower" do

  
    permit_params :follower_id, :following_id

     remove_filter :follower_id
    remove_filter :following_id
  
end
