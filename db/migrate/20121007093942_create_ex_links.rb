class CreateExLinks < ActiveRecord::Migration
  def change
    create_table :ex_links do |t|
      t.integer :place_id
      t.string :link

      t.timestamps
    end
  end
end
