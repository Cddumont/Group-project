class CreateVideogames < ActiveRecord::Migration[5.2]
  def change
    create_table :videogames do |t|
      t.string :name, null: false
      t.string :release_year
      t.string :description

      t.timestamps  null: false
    end
  end
end
