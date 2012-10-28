class AddTempToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :temp, :boolean
  end
end
