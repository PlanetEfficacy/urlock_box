class LinksController < ApplicationController
  before_action :authorize
  def index
    @link = Link.new
  end

  private
    def authorize
      redirect_to login_path unless current_user
    end
end
