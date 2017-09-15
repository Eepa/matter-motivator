class MotivationsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :check_mattermost_token, except: [:index]

  def index
    hello = { hello: "Hello world!" }
    respond_to do |format|
      format.html
      format.json { render json: hello }
    end
  end

  def motivate
    params_text = motivate_params[:text]
    motivation_text = "Kyllä se siitä"

    if !params_text.to_s.empty?
      splitted_text = params_text.split(' ').drop(1).join(' ')
      if !splitted_text.to_s.empty?
        motivation_text = motivation_text + " " + splitted_text
      end
    end

    respond_to do |format|
      matter_motivator = {username: "motivator", text: motivation_text + " :motivation-whale:" }
      format.html
      format.json { render json: matter_motivator }
    end
  end

  def slash_motivate
    params_text = motivate_params[:text]
    motivation_text = "Kyllä se siitä"

    if !params_text.to_s.empty?
      motivation_text = motivation_text + " " + params_text
    end

    respond_to do |format|
      matter_motivator = {response_type: "in_channel", username: "motivator", text: motivation_text + " :motivation-whale:" }
      format.html
      format.json { render json: matter_motivator }
    end
  end

  private
  def motivate_params
    params.permit(:token, :user_name, :text)
  end
end
