class UserInputForm < ApplicationRecord

  scope :by_user_id, -> (user_id) { where(user_id: user_id) }
  scope :by_form_id, -> (form_id) { where(form_id: form_id) }
  scope :by_form_ids, -> (form_ids) { where(form_id: form_ids) }

  scope :sum_total_taxable_income, -> { sum(:total_taxable_income) }
  scope :sum_total_tax_paid, -> { sum(:total_tax_paid) }

end
