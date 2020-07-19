class Form1099Service < FormService
  include Singleton

  def initialize; end

  def verify_request(obj = {})
    raise ApplicationError.validation_failed('Validation Failed') if obj[:total_income].nil? || obj[:total_business_expense].nil? || obj[:total_miles_driven].nil?
  end

  def calculate(obj = {})
    taxable_income = obj[:total_income] - obj[:total_business_expense]
    taxable_income = taxable_income - (2.1 * obj[:total_miles_driven])

    if taxable_income <= 10000
      total_taxable_income = taxable_income
    elsif taxable_income <= 50000
      total_taxable_income = taxable_income - 1000
    else
      total_taxable_income = taxable_income * 0.99
    end

    UserInputForm.create(total_income: obj[:total_income], total_business_expenses: obj[:total_business_expense],
                         total_miles_driven: obj[:total_miles_driven], total_taxable_income: total_taxable_income,
                         user_id: obj[:user].id, form_id: obj[:form].id)

  end

end