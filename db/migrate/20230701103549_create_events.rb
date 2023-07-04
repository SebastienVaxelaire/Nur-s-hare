class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :group, null: false, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
