class AddReferencesServeToImageDocker < ActiveRecord::Migration[5.2]
  def change
    add_reference :image_dockers, :server, foreign_key: true
  end
end
