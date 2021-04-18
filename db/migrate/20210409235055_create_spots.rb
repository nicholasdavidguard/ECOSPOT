class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :location
      t.integer :likes
      t.integer :dislikes
      t.text :description

      t.timestamps
    end
  end
end
