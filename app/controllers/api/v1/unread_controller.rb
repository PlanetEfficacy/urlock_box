class Api::V1::UnreadController < ApplicationController
  def index
    @links = current_user.links.where(status: 0)
    render json: @links
  end
end
