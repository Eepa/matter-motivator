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
      params_username = motivate_params[:user_name]
      params_text = motivate_path[:text]

      splitted_text = params_text.split(' ')
      mention_name = splitted_text[1]

      motivation_text = "Kyllä se siitä"
      if !mention_name.nil?
        motivation_text = motivation_text + mention_name
      end

      if params_token == MATTERMOST_TOKEN
        hello = {text: motivation_text + " :motivation-whale:" }
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
    params.permit(:token, :user_name, :text)
  end
end
