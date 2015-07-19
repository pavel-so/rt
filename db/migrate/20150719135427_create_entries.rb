class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :remote_ip
      t.string :query
      t.text :params
      t.text :headers
      t.text :cookies
      t.string :method
      t.text :raw_view
      t.integer :trap_id

      t.timestamps null: false
    end
  end
end
