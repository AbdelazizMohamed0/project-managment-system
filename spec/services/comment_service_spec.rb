require 'rails_helper'

RSpec.describe CommentService do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:valid_attributes) { { content: 'Test Comment' } }
  let(:service) { CommentService.new(user) }

  describe '#create_comment' do
    it 'creates a comment with the given attributes' do
      expect {
        comment = service.create_comment(project, valid_attributes)
        expect(comment).to be_persisted
        expect(comment.content).to eq(valid_attributes[:content])
        expect(comment.project).to eq(project)
        expect(comment.user).to eq(user)
      }.to change(Comment, :count).by(1)
    end

    it 'returns an unsaved comment if validation fails' do
      invalid_attributes = valid_attributes.merge(content: '')
      comment = service.create_comment(project, invalid_attributes)
      expect(comment).not_to be_persisted
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end

  describe '#destroy_comment' do
    it 'destroys the comment' do
      comment = create(:comment, project: project, user: user)
      
      expect {
        service.destroy_comment(comment)
      }.to change(Comment, :count).by(-1)
    end
  end
end 