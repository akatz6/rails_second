class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :comment
      t.string :alias
      t.integer :likes

      t.timestamps null: false
    end
  end
end
