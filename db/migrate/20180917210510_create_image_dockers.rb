class CreateImageDockers < ActiveRecord::Migration[5.2]
  def change
    create_table :image_dockers do |t|
      t.string :repository
      t.string :tag
      t.string :image_id
      t.string :created
      t.string :size

      t.timestamps
    end
  end
end
