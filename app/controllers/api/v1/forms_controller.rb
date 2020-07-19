class Api::V1::FormsController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    render json: {msg: 'Successfully Executed', data: Form.where(is_system_generated: false)}, status: :ok
  end

  def submit_form
    form = Form.find(params[:form_id])
    FormAbstractService.instance.perform(params)
    render json: {msg: 'Successfully Added'}, status: :ok
  end

end
