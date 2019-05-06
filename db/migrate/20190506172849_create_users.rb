class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.integer :room_id
      t.boolean :online

      t.timestamps
    end
  end
end
