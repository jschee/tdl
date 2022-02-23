class CreateLists < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'

    create_table :lists, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
