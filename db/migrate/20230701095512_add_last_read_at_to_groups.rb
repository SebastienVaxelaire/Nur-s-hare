class AddLastReadAtToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :last_read_at, :datetime
  end
end
