class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :alias
      t.integer :idea_id

      t.timestamps null: false
    end
  end
end
