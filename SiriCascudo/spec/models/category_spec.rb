require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it {expect(build(:category)).to be_valid}
    end
  end

  describe "validations" do
    context "when doesn't have name" do
      it { expect(build(:category, name: "" )).not_to be_valid }
    end

    context "when name isn't unique" do
      it "" do
        cat1 = create(:category, name: "testin")
        cat2 = build(:category, name: "testin")
        expect(cat1).to be_valid
        expect(cat2).not_to be_valid 
      end
    end
  end
  
end
