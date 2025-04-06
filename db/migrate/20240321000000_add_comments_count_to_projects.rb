class AddCommentsCountToProjects < ActiveRecord::Migration[8.0]
  def up
    add_column :projects, :comments_count, :integer, default: 0, null: false

    # Reset counter cache
    execute <<-SQL.squish
      UPDATE projects
      SET comments_count = (
        SELECT COUNT(*)
        FROM comments
        WHERE comments.project_id = projects.id
      )
    SQL
  end

  def down
    remove_column :projects, :comments_count
  end
end 