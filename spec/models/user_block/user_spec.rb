require 'rails_helper'

RSpec.describe UserBlock::User, type: :model do
 
  describe "Association" do
    it { should have_many(:properties) }
    it { should have_many(:orders) }
    it { should have_many(:favorite_properties) }
    it { should have_many(:ratings) }
  end

  describe "Validation" do 
    it {should validate_presence_of(:name) }
    it {should validate_presence_of(:email) }
    it {should validate_presence_of(:password) }
  end

end
