class RemoveUserIdFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :user_id
    add_column :comments, :author_id, :string
  end

  def down
    add_column :comments, :user_id, :string
    remove_column :comments, :author_id
  end
end
