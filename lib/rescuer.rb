module Rescuer
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :unknown_server_error
    rescue_from AuthenticationError, with: :authentication_error
    rescue_from ActionController::ParameterMissing, with: :bad_request_response
    rescue_from ForbiddenError, with: :forbidden_error
    rescue_from JWT::DecodeError, with: :verification_error
    rescue_from JWT::ExpiredSignature, with: :expired_signature
    rescue_from JWT::VerificationError, with: :verification_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  protected

  # Rescue from AuthenticationError
  def authentication_error
    prepare_unauthorized_response
    render json: { message: error_messages[:authentication_error] }
  end

  # Rescue from JWT::ExpiredSignature
  def expired_signature
    prepare_unauthorized_response
    render json: { message: error_messages[:expired_token] }
  end

  # Rescue from JWT::VerificationError
  def verification_error
    prepare_unauthorized_response
    render json: { message: error_messages[:token_verification] }
  end

  def forbidden_error(error)
    render json: { message: error.message }, status: :forbidden
  end

  def not_found
    render json: { message: error_messages[:record_not_found] }, status: :not_found
  end

  def bad_request_response
    render json: { message: error_messages[:bad_request] }, status: :bad_request
  end


  def unknown_server_error(e)
    message = "#{e.class} \n #{e.message}\n"
    message << e.annotated_source_code.to_s if e.respond_to?(:annotated_source_code)
    message << "\n" << ActionDispatch::ExceptionWrapper.new(env, e)
                       .application_trace.join('\n')
    logger.error "#{message}\n\n"
    render json: { message: error_messages[:internal_server_error] },
           status: :internal_server_error
  end

end
