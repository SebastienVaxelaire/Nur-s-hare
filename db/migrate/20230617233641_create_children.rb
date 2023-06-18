class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.string :name
      t.string :gender
      t.date :birthday
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
