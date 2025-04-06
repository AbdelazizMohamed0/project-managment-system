require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:current_status) }
    it { should validate_inclusion_of(:current_status).in_array(Project::STATUSES) }
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:status_changes).dependent(:destroy) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:project)).to be_valid
    end

    it 'has a valid factory with not_started trait' do
      expect(build(:project, :not_started)).to be_valid
    end

    it 'has a valid factory with in_progress trait' do
      expect(build(:project, :in_progress)).to be_valid
    end

    it 'has a valid factory with on_hold trait' do
      expect(build(:project, :on_hold)).to be_valid
    end

    it 'has a valid factory with completed trait' do
      expect(build(:project, :completed)).to be_valid
    end
  end

end 