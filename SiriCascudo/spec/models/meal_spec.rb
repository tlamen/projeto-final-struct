require 'rails_helper'

RSpec.describe Meal, type: :model do

  describe 'factory' do
    context 'when using standard factory' do
      it {expect(build(:meal)).to be_valid}
    end
  end
  describe "validations" do
    context "when name isn't unique" do
      it "" do
        meal1 = create(:meal, name: "testin")
        meal2 = build(:meal, name: "testin")
        expect(meal1).to be_valid
        expect(meal2).not_to be_valid 
      end
    end

    context "when it has no description" do
      it { expect(build(:meal, description: "")).not_to be_valid }
    end

    context "when it has no price" do
      it { expect(build(:meal, price: nil)).not_to be_valid }
    end
    
    context "when it has no name" do
      it { expect(build(:meal, name: "")).not_to be_valid }
    end
    
    context "if price is smaller or equal to 0" do
      it { expect(build(:meal, price: 0)).not_to be_valid }
      it { expect(build(:meal, price: -1)).not_to be_valid }
    end
    
  end

end
