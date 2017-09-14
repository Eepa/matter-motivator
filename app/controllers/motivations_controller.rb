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
      params_text = motivate_params[:text]
      motivation_text = "Kyllä se siitä"

      if !params_text.to_s.empty?
        splitted_text = params_text.split(' ').drop(1).join(' ')
        if !splitted_text.to_s.empty?
          motivation_text = motivation_text + " " + splitted_text
        end
      end

      if params_token == MATTERMOST_TOKEN || params_token == SECOND_MATTERMOST_TOKEN
        matter_motivator = {username: "motivator", text: motivation_text + " :motivation-whale:" }
        format.html
        format.json { render json: matter_motivator }
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
