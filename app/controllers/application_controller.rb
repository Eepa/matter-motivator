class ApplicationController < ActionController::Base
  respond_to :json, :html
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def json_request?
    request.format.json?
  end

end
