class RemoveAttrsFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :user_id
    remove_column :comments, :place_id
  end

  def down
    add_column :comments, :place_id, :string
    add_column :comments, :user_id, :string
  end
end
