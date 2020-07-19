class FormW2Service < FormService
  include Singleton

  def initialize; end

  def verify_request(obj = {})
    raise ApplicationError.validation_failed('Validation Failed') if obj[:total_income].nil? || obj[:total_tax_paid].nil?
  end

  def calculate(obj = {})

    if obj[:total_income] <= 10000
      total_taxable_income = obj[:total_income]
    elsif obj[:total_income] <= 50000
      total_taxable_income = obj[:total_income]  - 1000
    else
      total_taxable_income = obj[:total_income]  * 0.98
    end

    UserInputForm.create(total_income: obj[:total_income], total_tax_paid: obj[:total_tax_paid],
                         total_taxable_income: total_taxable_income, user_id: obj[:user].id, form_id: obj[:form].id)
  end

end