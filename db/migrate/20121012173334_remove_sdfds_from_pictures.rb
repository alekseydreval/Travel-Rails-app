class RemoveSdfdsFromPictures < ActiveRecord::Migration
  def up
    remove_column :pictures, :integer
  end

  def down
    add_column :pictures, :integer, :string
  end
end
