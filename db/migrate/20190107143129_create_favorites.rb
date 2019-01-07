class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :location
      t.timestamps
    end
    add_index :favorites, :location
  end
end
