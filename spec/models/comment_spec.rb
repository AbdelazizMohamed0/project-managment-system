require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:content) }
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:comment)).to be_valid
    end
  end

  describe 'default scope' do
    it 'orders comments by created_at in descending order' do
      comment1 = create(:comment, created_at: 1.day.ago)
      comment2 = create(:comment, created_at: 2.days.ago)
      comment3 = create(:comment, created_at: 3.days.ago)
      
      expect(Comment.all).to eq([comment1, comment2, comment3])
    end
  end
end 