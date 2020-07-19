class Api::V1::FormsController < ApplicationController

  protect_from_forgery with: :null_session

  before_action :fetch_user, only: :submit_form
  before_action :fetch_form, only: :submit_form

  def index
    render json: {msg: 'Successfully Executed', data: Form.where(is_system_generated: false)}, status: :ok
  end

  def submit_form
    obj = params
    obj[:form] = @form
    obj[:user] = @user

    FormAbstractService.instance.perform(params)
    render json: {msg: 'Successfully Added'}, status: :ok
  end

  def fetch_user
    raise ApplicationError.validation_failed('User Id not present') if params[:user_id].nil?
    @user = User.find(params[:user_id])
  end

  def fetch_form
    raise ApplicationError.validation_failed('Form Id not present') if params[:form_id].nil?
    @form = Form.find(params[:form_id])
  end

end
