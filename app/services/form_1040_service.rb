class Form1040Service < FormService
  include Singleton

  def initialize; end

  def verify_request(obj = {})
    if UserInputForm.by_user_id(obj[:user_id]).by_form_id(1).count == 0 || UserInputForm.by_user_id(obj[:user_id]).by_form_id(2).count == 0
      raise ApplicationError.validation_failed('Validation Failed')
    end
  end

  def calculate(obj = {})
    total_taxable_income = UserInputForm.by_user_id(obj[:user_id]).by_form_ids([1,2]).sum_total_taxable_income
    total_tax_paid = UserInputForm.by_user_id(obj[:user_id]).by_form_id(2).sum_total_tax_paid

    if total_taxable_income <= 100000
      total_tax_liability = total_taxable_income * 1.2
    else
      total_tax_liability = total_taxable_income * 1.28
    end

    tax_difference = total_tax_paid - total_tax_liability

    SystemGeneratedForm.create(total_tax_paid: total_tax_paid, total_tax_liability: total_tax_liability,
                               total_difference: tax_difference, total_taxable_income: total_taxable_income,
                               user_id: obj[:user_id], form_id: obj[:form_id])

  end

end