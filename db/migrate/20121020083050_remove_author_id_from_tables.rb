class RemoveAuthorIdFromTables < ActiveRecord::Migration
  def up
    remove_column :comments, :author_id
    remove_column :pictures, :author_id
    remove_column :places, :author_id

    add_column :comments, :user_id, :integer
    add_column :pictures, :user_id, :integer
    add_column :places, :user_id, :integer
  end

  def down
    add_column :comments, :author_id, :integer
    add_column :pictures, :author_id, :integer
    add_column :places, :author_id, :integer

    remove_column :comments, :user_id
    remove_column :pictures, :user_id
    remove_column :places, :user_id
  end
end
