class AddImgToVideogames < ActiveRecord::Migration[5.2]
  def change
    add_column :videogames, :image, :string
  end
end
