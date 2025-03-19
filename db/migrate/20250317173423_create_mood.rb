class CreateMood < ActiveRecord::Migration[7.1]
  def change
    create_table :moods do |t|
      t.string :mood
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
