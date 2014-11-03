class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :body, null: false
      t.integer :user_id, null: false
      t.boolean :privacy, null: false

      t.timestamps
    end
  end
end
