require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'factory' do
    context 'when using standard factory' do
      it {expect(build(:user)).to be_valid}
      it { expect(create(:user).authentication_token.size).to be <= 30 }
    end
  end


  describe 'validations' do
    context "when user doesn't have email" do
      it { expect(build(:user, email: nil)).not_to be_valid }
    end
    context "when user doesn't have name" do
      it { expect(build(:user, name: nil)).not_to be_valid }
    end
    context "when user doesn't have password" do
      it { expect(build(:user, password: nil, password_confirmation: nil)).not_to be_valid }
    end
    context "when user has different password and password_confirmation" do
      it { expect(build(:user, password: "123123")).not_to be_valid }
    end
    context "when user is_admin: nil" do
      it { expect(build(:user, is_admin: nil)).not_to be_valid }
    end
    context "when user is_admin: false" do
      it { expect(build(:user, is_admin: false)).to be_valid }
    end
    context "email must be unique" do
      it "" do
        user1 = create(:user,email:"unique@email")
        user2 = build(:user, email:"unique@email")
        expect(user1).to be_valid
        expect(user2).not_to be_valid  
      end
    end
    
  end

end
