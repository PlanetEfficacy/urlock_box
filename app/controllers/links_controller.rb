class LinksController < ApplicationController
  before_action :authorize
  def index
  end

  private
    def authorize
      redirect_to login_path unless current_user
    end
end
