require 'rails_helper'

RSpec.describe StatusChangeService do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user, current_status: 'Not Started') }
  let(:service) { StatusChangeService.new(user) }

  describe '#create_status_change' do
    it 'creates a status change record' do
      expect {
        result = service.create_status_change(project, 'Not Started', 'In Progress')
        expect(result).to be_a(StatusChange)
        expect(project.status_changes.last.to_status).to eq('In Progress')
        expect(project.status_changes.last.from_status).to eq('Not Started')
        expect(project.status_changes.last.user).to eq(user)
      }.to change(StatusChange, :count).by(1)
    end

    it 'returns false if the status is invalid' do
      expect {
        result = service.create_status_change(project, 'Not Started', 'Invalid Status')
        expect(result).to be false
      }.not_to change(StatusChange, :count)
    end
  end
end 