class AddPlaceRadiusToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :place_radius, :integer
  end
end
