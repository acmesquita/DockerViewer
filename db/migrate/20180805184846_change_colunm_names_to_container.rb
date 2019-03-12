class ChangeColunmNamesToContainer < ActiveRecord::Migration[5.2]
  def change
    rename_column :containers, :name, :names
  end
end
