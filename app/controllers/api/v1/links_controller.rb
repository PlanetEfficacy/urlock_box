class Api::V1::LinksController < ApplicationController
  def create
    @link = Link.new(link_params)
    if @link.save
      render json: { id: @link.id,
                     title: @link.title,
                     url: @link.url,
                     status: @link.status }
    else
      render json: { message: @link.errors.full_messages.first }, status: :bad_request
    end
  end

  private
    def link_params
      params.require(:link).permit(:title, :url)
    end
end
