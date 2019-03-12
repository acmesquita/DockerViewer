class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :ip
      t.string :chave_ssh
      t.string :login

      t.timestamps
    end
  end
end
