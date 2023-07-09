class AddEventToPlannings < ActiveRecord::Migration[7.0]
  def change
    add_column :plannings, :event, :boolean, default: false
  end
end
