class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :place_id
      t.string :integer

      t.timestamps
    end
  end
end
