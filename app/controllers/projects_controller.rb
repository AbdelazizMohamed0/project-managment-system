class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @projects = project_service.list_projects
  end

  def show
    @project, @timeline = project_service.find_project_with_timeline(@project.id)
  end

  def new
    @project = Project.new
    authorize! :create, @project
  end

  def edit
    authorize! :update, @project
  end

  def create
    @project = project_service.create_project(project_params)
    authorize! :create, @project

    if @project.persisted?
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @project
    if project_service.update_project(@project, project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @project
    project_service.destroy_project(@project)
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  def update_status
    authorize! :update_status, @project
    if project_service.update_project_status(@project, params[:status])
      redirect_to @project, notice: 'Project status was successfully updated.'
    else
      redirect_to @project, alert: 'Invalid status'
    end
  end

  private

  def set_project
    @project = project_service.find_project(params[:id])
    redirect_to projects_path, alert: 'Project not found' unless @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :current_status)
  end

  def project_service
    @project_service ||= ProjectService.new(current_user)
  end
end
