class AddLastReadAtToFamiliesGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :families_groups, :last_read_at, :datetime
  end
end
