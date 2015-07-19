class CreateTraps < ActiveRecord::Migration
  def change
    create_table :traps do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
