class Api::V1::ReadController < ApplicationController
  def index
    @links = current_user.links.where(status: 1)
    render json: @links
  end
end
