require 'rails_helper'

RSpec.describe StatusChange, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:from_status) }
    it { should validate_presence_of(:to_status) }
    it { should validate_inclusion_of(:to_status).in_array(Project::STATUSES) }
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:status_change)).to be_valid
    end
  end

  describe 'default scope' do
    it 'orders status changes by created_at in descending order' do
      change1 = create(:status_change, created_at: 1.day.ago)
      change2 = create(:status_change, created_at: 2.days.ago)
      change3 = create(:status_change, created_at: 3.days.ago)
      
      expect(StatusChange.all).to eq([change1, change2, change3])
    end
  end
end 