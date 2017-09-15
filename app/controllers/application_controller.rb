class ApplicationController < ActionController::Base
  respond_to :json, :html
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def json_request?
    request.format.json?
  end

  def check_mattermost_token
    mattermost_tokens = get_mattermost_tokens
    params_token = motivate_params[:token]

    unless mattermost_tokens.include? params_token
      respond_to do |format|
        format.html
        format.json { head :forbidden }
      end
    end
  end

  private

  def get_mattermost_tokens
    unless MATTERMOST_TOKEN.nil?
      MATTERMOST_TOKEN.split(':')
    end
  end

  def motivate_params
    params.permit(:token)
  end

end
