class AddColunmPortToServer < ActiveRecord::Migration[5.2]
  def change
    add_column :servers, :port, :string
  end
end
