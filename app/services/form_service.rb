class FormService
  include AbstractInterface

  def perform(obj)
    verify_request(obj)
    calculate(obj)
  end

  def verify_request(obj = {})
    FormService.method_not_implemented(self)
  end

  def calculate(obj = {})
    FormService.method_not_implemented(self)
  end

end
