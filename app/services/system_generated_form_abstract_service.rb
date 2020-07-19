class SystemGeneratedFormAbstractService < FormService
  include Singleton

  def initialize; end

  def perform(obj)

    response = {}

    case obj[:form_id].to_i
    when 3
      response = Form1040Service.instance.perform(obj)
    end

    response

  end

end