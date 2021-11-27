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
    
    context "when it already exists" do
      it "" do
        fav1 = create(:favorite)
        fav2 = build(:favorite)
        expect(fav1).to be_valid
        expect(fav2).not_to be_valid  
      end
    end

    context "user having more than 1 fav" do
      it "" do
        create(:meal, id: 333)
        fav1 = create(:favorite)
        fav2 = build(:favorite, meal_id: 333)
        expect(fav1).to be_valid
        expect(fav2).to be_valid
      end
    end
    
    context "meal being favorite of more than 1 user" do
      it "" do
        create(:user, id: 333)
        fav1 = create(:favorite)
        fav2 = build(:favorite, user_id: 333)
        expect(fav1).to be_valid
        expect(fav2).to be_valid
      end
    end
    
    
  end
  
end
