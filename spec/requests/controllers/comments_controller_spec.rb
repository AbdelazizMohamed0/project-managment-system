require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:valid_attributes) { { content: 'Test Comment' } }

  before do
    # Use Warden test helpers for authentication
    login_as(user, scope: :user)
  end

  describe 'GET /projects/:project_id/comments/new' do
    it 'renders the new comment form' do
      get new_project_comment_path(project)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New Comment')
    end
  end

  describe 'POST /projects/:project_id/comments' do
    it 'creates a comment and redirects to project' do
      expect {
        post project_comments_path(project), params: { comment: valid_attributes }
      }.to change(Comment, :count).by(1)

      expect(response).to redirect_to(project_path(project))
      follow_redirect!
      expect(response.body).to include('Comment was successfully created')
    end
  end

  describe 'DELETE /projects/:project_id/comments/:id' do
    it 'deletes the comment and redirects to project' do
      comment = create(:comment, project: project, user: user)
      
      expect {
        delete project_comment_path(project, comment)
      }.to change(Comment, :count).by(-1)

      expect(response).to redirect_to(project_path(project))
      follow_redirect!
      expect(response.body).to include('Comment was successfully destroyed')
    end
  end
end 