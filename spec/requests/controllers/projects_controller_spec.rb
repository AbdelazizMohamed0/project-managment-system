require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:valid_attributes) { { name: 'Test Project', description: 'Test Description' } }

  before do
    # Use Warden test helpers for authentication
    login_as(user, scope: :user)
  end

  describe 'GET /projects' do
    it 'displays the list of projects' do
      project1 = create(:project, user: user)
      project2 = create(:project, user: other_user)
      
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(project1.name)
      expect(response.body).to include(project2.name)
      expect(response.body).to include(user.name)
      expect(response.body).to include(other_user.name)
    end
  end

  describe 'GET /projects/:id' do
    it 'displays the project details with timeline' do
      project = create(:project, user: user)
      comment = create(:comment, project: project, user: user)
      status_change = create(:status_change, project: project, user: user)
      
      get project_path(project)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(project.name)
      expect(response.body).to include(project.description)
      expect(response.body).to include(comment.content)
      expect(response.body).to include(status_change.to_status)
    end
  end

  describe 'POST /projects' do
    it 'creates a project and redirects to show page' do
      expect {
        post projects_path, params: { project: valid_attributes }
      }.to change(Project, :count).by(1)

      expect(response).to redirect_to(project_path(Project.last))
      follow_redirect!
      expect(response.body).to include('Project was successfully created')
    end
  end

  describe 'PATCH /projects/:id/update_status' do
    it 'updates the project status and redirects to show page' do
      project = create(:project, user: user, current_status: 'Not Started')
      
      expect {
        patch update_status_project_path(project), params: { status: 'In Progress' }
      }.to change(StatusChange, :count).by(1)
      
      expect(response).to redirect_to(project_path(project))
      follow_redirect!
      expect(response.body).to include('Project status was successfully updated')
    end
  end
end 