class ProjectService < BaseService
  def initialize(user = nil)
    super(user)
    @status_change_service = StatusChangeService.new(user)
  end

  def list_projects
    Project.includes(:user).all
  end

  def find_project(id)
    Project.includes(:user).find(id)
  end

  def find_project_with_timeline(id)
    project = find_project(id)
    return [nil, []] unless project

    timeline = (project.comments.includes(:user) + project.status_changes.includes(:user))
                      .sort_by(&:created_at)
    [project, timeline]
  end

  def create_project(attributes)
    project = current_user.projects.build(attributes)
    project.current_status ||= 'Not Started'
    project.save
    project
  end

  def update_project(project, attributes)
    project.update(attributes)
  end

  def update_project_status(project, new_status)
    return false unless Project::STATUSES.include?(new_status)
    
    old_status = project.current_status
    if project.update(current_status: new_status)
      @status_change_service.create_status_change(project, old_status, new_status)
      true
    else
      false
    end
  end

  def destroy_project(project)
    project.destroy
  end
end 