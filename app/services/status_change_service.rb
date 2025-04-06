class StatusChangeService < BaseService
  def create_status_change(project, from_status, to_status)
    return false unless Project::STATUSES.include?(to_status)
    
    project.status_changes.create!(
      from_status: from_status,
      to_status: to_status,
      user: current_user
    )
  end
end 