require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it {expect(build(:favorite)).to be_valid}
    end
  end


  describe "validations" do
    context "when it doesn't have user" do
      it { expect(build(:favorite, user_id: nil)).not_to be_valid }
    end

    context "when it doesn' have meal" do
      it { expect(build(:favorite, meal_id: nil)).not_to be_valid }
    end
    
    
  end
  
end
