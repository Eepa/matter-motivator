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
    hello = {hello: "Hello world" }
    respond_to do |format|
      format.html
      format.json { render json: hello }
    end
  end
end
