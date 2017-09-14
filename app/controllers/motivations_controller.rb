class MotivationsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

  def index
    hello = {hello: "Hello world!" }
    respond_to do |format|
      format.html
      format.json { render json: hello }
    end
  end

  def motivate
    respond_to do |format|

      params_token = motivate_params[:token]

      if params_token == MATTERMOST_TOKEN
        hello = {text: "Kyllä se siitä" }
        format.html
        format.json { render json: hello }
      else
        format.html
        format.json {render json: {}, status: :internal_server_error }
      end

    end
  end

  private
  def motivate_params
    params.permit(:token)
  end
end
