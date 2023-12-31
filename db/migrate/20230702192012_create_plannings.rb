class CreatePlannings < ActiveRecord::Migration[7.0]
  def change
    create_table :plannings do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
