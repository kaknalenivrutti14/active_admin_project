require 'rails_helper'

RSpec.describe FollowBlock::Follower, type: :model do
  
  describe "associations" do
    it { should belong_to(:follower).class_name('UserBlock::User').with_foreign_key('follower_id') }
    it { should belong_to(:following).class_name('UserBlock::User').with_foreign_key('following_id') }
  end

  describe "ransackable attributes" do
    it "should include specific attributes" do
      expect(FollowBlock::Follower.ransackable_attributes).to contain_exactly("created_at", "follower_id", "following_id", "id", "updated_at")
    end
  end

  describe "ransackable associations" do
    it "should include specific associations" do
      expect(FollowBlock::Follower.ransackable_associations).to contain_exactly("follower", "following")
    end
  end
end
