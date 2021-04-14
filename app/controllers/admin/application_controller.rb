class Admin::ApplicationController < ActionController::Base
  before_action :auth

  layout 'application'

  def auth
    redirect_to post_path unless current_user.admin?
  end
end
