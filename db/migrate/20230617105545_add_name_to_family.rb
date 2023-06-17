class AddNameToFamily < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :name, :string
  end
end
