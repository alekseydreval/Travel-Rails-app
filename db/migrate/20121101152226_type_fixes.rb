class TypeFixes < ActiveRecord::Migration
  def change 
    change_column  :pictures, :place_id, :integer
  end
end
