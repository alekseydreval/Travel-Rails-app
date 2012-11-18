class AddCoordsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :coords, :string
  end
end
