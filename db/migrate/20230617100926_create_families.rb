class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.references :user, null: false, foreign_key: true
      t.string :husband_name
      t.string :wife_name
      t.string :address
      t.string :phone_number
      t.text :description
      t.text :key_points

      t.timestamps
    end
  end
end
