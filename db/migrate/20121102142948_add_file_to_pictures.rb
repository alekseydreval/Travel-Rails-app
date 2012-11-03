class AddFileToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :file_contents, :string
  end
end
