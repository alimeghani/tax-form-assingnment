class CreateSystemGeneratedForms < ActiveRecord::Migration[6.0]
  def change
    create_table :system_generated_forms do |t|
      t.numeric :total_tax_paid
      t.numeric :total_tax_liability
      t.integer :total_difference
      t.numeric :total_taxable_income

      t.references :user, foreign_key: true
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
