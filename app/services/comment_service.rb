class CommentService < BaseService
  def initialize(user = nil)
    super(user)
  end

  def create_comment(project, attributes)
    comment = project.comments.build(attributes.merge(user: current_user))
    comment.save
    comment
  end


  def destroy_comment(comment)
    comment.destroy
  end
end 