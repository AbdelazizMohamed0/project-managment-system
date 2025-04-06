class AddNameToUsers < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:users, :name)
      add_column :users, :name, :string
    end
  end
end
