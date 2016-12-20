class Api::V1::LinksController < ApplicationController
  def index
    @links = current_user.links
    render json: @links
  end

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

  def update
    @link = Link.update(params[:id],
                        title: params[:link][:title],
                        url: params[:link][:url],
                        status: params[:link][:status])
    if @link
      render json: { id: @link.id,
                     title: @link.title,
                     url: @link.url,
                     status: @link.status }
    end
  end

  private
    def link_params
      whitelist = params.require(:link).permit(:title, :url)
      whitelist[:user] = current_user
      return whitelist
    end
end
