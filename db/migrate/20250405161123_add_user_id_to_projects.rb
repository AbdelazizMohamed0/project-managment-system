class AddUserIdToProjects < ActiveRecord::Migration[8.0]
  def change
    add_reference :projects, :user, null: true, foreign_key: true
    
    reversible do |dir|
      dir.up do
        if User.any?
          first_user = User.first
          Project.update_all(user_id: first_user.id)
        end
      end
    end
    
    # Make the column non-nullable
    change_column_null :projects, :user_id, false
  end
end
