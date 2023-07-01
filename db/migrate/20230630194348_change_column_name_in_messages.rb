class ChangeColumnNameInMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :conent, :content
  end
end
