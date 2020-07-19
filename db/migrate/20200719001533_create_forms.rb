class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.string :name, null: false
      t.boolean "is_system_generated", null: false
      t.boolean "is_active", default: true, null: false

      t.timestamps
    end
  end
end
