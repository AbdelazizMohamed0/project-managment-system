require 'rails_helper'

RSpec.describe ProjectService do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:valid_attributes) { { name: 'Test Project', description: 'Test Description', user: user } }
  let(:service) { ProjectService.new(user) }

  describe '#list_projects' do
    it 'returns all projects with eager loaded users' do
      project1 = create(:project, user: user)
      project2 = create(:project, user: other_user)
      
      projects = service.list_projects
      expect(projects).to include(project1, project2)
      expect(projects.first.association(:user).loaded?).to be true
    end
  end

  describe '#find_project' do
    it 'returns a project with eager loaded user' do
      project = create(:project, user: user)
      
      found_project = service.find_project(project.id)
      expect(found_project).to eq(project)
      expect(found_project.association(:user).loaded?).to be true
    end
  end

  describe '#find_project_with_timeline' do
    it 'returns a project with eager loaded associations' do
      project = create(:project, user: user)
      comment = create(:comment, project: project, user: user)
      status_change = create(:status_change, project: project, user: user)
      
      found_project, timeline = service.find_project_with_timeline(project.id)
      expect(found_project).to eq(project)
      expect(found_project.association(:user).loaded?).to be true
      expect(timeline).to include(comment, status_change)
      expect(timeline.first.association(:user).loaded?).to be true
    end
  end

  describe '#create_project' do
    it 'creates a project with the given attributes' do
      expect {
        project = service.create_project(valid_attributes)
        expect(project).to be_persisted
        expect(project.name).to eq(valid_attributes[:name])
        expect(project.description).to eq(valid_attributes[:description])
        expect(project.user).to eq(user)
      }.to change(Project, :count).by(1)
    end
  end

  describe '#update_project' do
    it 'updates a project with the given attributes' do
      project = create(:project, user: user)
      new_attributes = { name: 'Updated Project' }
      
      expect(service.update_project(project, new_attributes)).to be true
      project.reload
      expect(project.name).to eq('Updated Project')
    end
  end

  describe '#update_project_status' do
    it 'updates the project status and creates a status change' do
      project = create(:project, user: user, current_status: 'Not Started')
      
      expect {
        expect(service.update_project_status(project, 'In Progress')).to be true
        project.reload
        expect(project.current_status).to eq('In Progress')
        expect(project.status_changes.last.to_status).to eq('In Progress')
      }.to change(StatusChange, :count).by(1)
    end
  end

  describe '#destroy_project' do
    it 'destroys the project' do
      project = create(:project, user: user)
      
      expect {
        service.destroy_project(project)
      }.to change(Project, :count).by(-1)
    end
  end
end 