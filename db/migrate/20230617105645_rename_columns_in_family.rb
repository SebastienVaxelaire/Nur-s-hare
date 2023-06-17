class RenameColumnsInFamily < ActiveRecord::Migration[7.0]
  def change
      rename_column :families, :husband_name, :husband_first_name
      rename_column :families, :wife_name, :wife_first_name
  end
end
