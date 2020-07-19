class ApplicationController < ActionController::Base

  rescue_from StandardError do |error|
    log_error(error)
    render_error ApplicationError.something_went_wrong(I18n.t(:something_went_wrong))
  end

  rescue_from ActionController::ParameterMissing do |error|
    log_error(error)
    render_error ApplicationError.parameter_missing(error)
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render_error ApplicationError.something_went_wrong(I18n.t(:something_went_wrong))
  end

  rescue_from ActiveModel::ValidationError do |error|
    log_error(error)
    render_error ApplicationError.validation_failed(error)
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    log_error(error)
    render_error ApplicationError.not_found(I18n.t(:not_found))
  end

  private

  def render_error(error)
    render json: error, status: error.http_status
  end

  def log_error(error)
    Rails.logger.error "#{error.class}: #{error}"
    Rails.logger.debug error.backtrace.join("\n")
  end

end


class ApplicationError < StandardError
  DEFAULT_CODE = 1000
  CODES = {
      internal_server_error: {code: 1000, http_status: 500},
      not_found: {code: 1002, http_status: 404},
      validation_failed: {code: 1020, http_status: 422},
      something_went_wrong: {code: 1407, http_status: 500},
      invalid_parameters: {code: 1408, http_status: 400},

  }.freeze

  attr_reader :code

  def initialize(msg, name = nil)
    name = :general_error unless name.in?(CODES.keys)
    @code = CODES[name][:code]
    @name = name
    super(msg)
  end

  def self.method_missing(name, msg)
    return super unless name.in?(CODES.keys)
    new(msg.to_s, name)
  end

  def self.respond_to_missing?(name, _respond_to_private = false)
    name.in?(CODES.keys) || super
  end

  def to_json(_options)
    {
        code: code,
        message: message
    }.to_json
  end

  def http_status
    CODES[name][:http_status]
  end

  private

  attr_reader :name
end
