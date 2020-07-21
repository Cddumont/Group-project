class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :body
      t.string :title
      t.belongs_to :videogame, null: false

      t.timestamps null: false
    end
  end
end
