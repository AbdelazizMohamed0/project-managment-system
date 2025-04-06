class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_comment, only: [:destroy]

  def new
    @comment = @project.comments.build
    authorize! :create, @comment
  end

  def create
    @comment = comment_service.create_comment(@project, comment_params)
    authorize! :create, @comment

    if @comment.persisted?
      redirect_to @project, notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @comment
    comment_service.destroy_comment(@comment)
    redirect_to @project, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_project
    @project = project_service.find_project(params[:project_id])
    redirect_to projects_path, alert: 'Project not found' unless @project
  end

  def set_comment
    @comment = @project.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to @project, alert: 'Comment not found'
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_service
    @comment_service ||= CommentService.new(current_user)
  end

  def project_service
    @project_service ||= ProjectService.new(current_user)
  end
end
