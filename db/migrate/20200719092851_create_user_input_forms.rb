class CreateUserInputForms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_input_forms do |t|
      t.numeric :total_income
      t.numeric :total_business_expenses
      t.integer :total_miles_driven
      t.numeric :total_tax_paid
      t.numeric :total_taxable_income

      t.references :user, foreign_key: true
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
