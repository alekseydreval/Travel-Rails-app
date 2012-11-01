class Jhsgj < ActiveRecord::Migration

def change 
  remove_column  :pictures, :place_id
  add_column :pictures, :place_id,  :integer
end

end
