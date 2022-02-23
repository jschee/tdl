class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :description
      t.references :list, null: false, foreign_key: true, type: :uuid
      t.integer :position
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
