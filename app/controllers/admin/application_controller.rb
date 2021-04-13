class Admin::ApplicationController < ActionController::Base

  before_action :auth

  layout "application"

  def auth
    if !current_user.admin?
      redirect_to post_path
    end
  end


end
