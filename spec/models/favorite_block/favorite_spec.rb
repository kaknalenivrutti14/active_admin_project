require 'rails_helper'

RSpec.describe FavoriteBlock::Favorite, type: :model do
  
  describe "association" do 
    it { should belong_to(:property).class_name("PropertyBlock::Property") }
    it { should belong_to(:user).class_name("UserBlock::User") }
  end

end
