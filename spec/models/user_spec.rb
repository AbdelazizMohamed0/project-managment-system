require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    
    it 'validates email format' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('is invalid')
      
      user.email = 'valid@example.com'
      expect(user).to be_valid
    end
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:status_changes).dependent(:destroy) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end
end 