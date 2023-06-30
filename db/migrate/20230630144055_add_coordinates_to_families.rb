class AddCoordinatesToFamilies < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :latitude, :float
    add_column :families, :longitude, :float
  end
end
