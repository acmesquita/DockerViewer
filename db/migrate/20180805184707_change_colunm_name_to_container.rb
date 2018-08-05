class ChangeColunmNameToContainer < ActiveRecord::Migration[5.2]
  def change
    rename_column :containers, :create, :created
  end
end
