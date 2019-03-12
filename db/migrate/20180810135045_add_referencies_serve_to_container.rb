class AddReferenciesServeToContainer < ActiveRecord::Migration[5.2]
  def change
    add_reference :containers, :server, foreign_key: true
  end
end
