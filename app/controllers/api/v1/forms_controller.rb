class Api::V1::FormsController < ApplicationController

  protect_from_forgery with: :null_session

  before_action :fetch_user, only: %i[submit_form generate_form]
  before_action :fetch_user_input_form, only: :submit_form
  before_action :fetch_system_generated_form, only: :generate_form

  def index
    render json: {msg: 'Successfully Executed', data: Form.where(is_system_generated: false)}, status: :ok
  end

  def submit_form
    obj = params
    obj[:form] = @form
    obj[:user] = @user

    UserInputFormAbstractService.instance.perform(params)
    render json: {msg: 'Successfully Added'}, status: :ok
  end

  def generate_form
    form = SystemGeneratedFormAbstractService.instance.perform(params)
    render json: {msg: 'Successfully Added', data: form}, status: :ok
  end

  def fetch_user
    raise ApplicationError.validation_failed('User Id not present') if params[:user_id].nil?
    @user = User.find(params[:user_id])
  end

  def fetch_user_input_form
    raise ApplicationError.validation_failed('Form Id not present') if params[:form_id].nil?
    @form = Form.where(is_system_generated: false).find(params[:form_id])
  end

  def fetch_system_generated_form
    raise ApplicationError.validation_failed('Form Id not present') if params[:form_id].nil?
    @form = Form.where(is_system_generated: true).find(params[:form_id])
  end

end
