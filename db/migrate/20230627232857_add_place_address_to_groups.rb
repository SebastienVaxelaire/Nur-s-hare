class AddPlaceAddressToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :place_address, :string
  end
end
