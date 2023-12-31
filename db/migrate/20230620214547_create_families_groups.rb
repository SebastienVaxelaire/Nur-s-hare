class CreateFamiliesGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :families_groups do |t|
      t.references :family, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :confirmation
      t.timestamps
    end
  end
end
