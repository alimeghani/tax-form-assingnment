class UserInputFormAbstractService < FormService
  include Singleton

  def initialize; end

  def perform(obj)

    case obj[:form_id].to_i
    when 1
      Form1099Service.instance.perform(obj)
    when 2
      FormW2Service.instance.perform(obj)
    end
  end

end