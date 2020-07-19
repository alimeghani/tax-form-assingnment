class Api::V1::UsersController < ApplicationController
  def index
    render json: {msg: 'Successfully Executed', data: User.all}, status: :ok
  end
end
