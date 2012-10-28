class RemovePictureIdFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :picture_id
    add_column :comments, :user_id, :string
  end

  def down
    remove_column :comments, :user_id
    add_column :comments, :picture_id, :string
  end
end
