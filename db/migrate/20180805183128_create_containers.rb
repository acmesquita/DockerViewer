class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.string :container_id
      t.string :image
      t.string :command
      t.string :create
      t.string :status
      t.string :ports
      t.string :name

      t.timestamps
    end
  end
end
