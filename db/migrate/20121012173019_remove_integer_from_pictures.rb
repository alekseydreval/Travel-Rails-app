class RemoveIntegerFromPictures < ActiveRecord::Migration
  def up
  	remove_column :pictures, :integer
  end

  def down
  end
end
