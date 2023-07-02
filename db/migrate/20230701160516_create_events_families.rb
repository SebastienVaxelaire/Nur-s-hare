class CreateEventsFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :events_families do |t|
      t.references :family, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
