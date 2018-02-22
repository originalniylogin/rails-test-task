class AdminController < ApplicationController
  before_action :require_login

  private

  def require_login
    unless view_context.admin_logged_in?
      redirect_to admin_login_path
    end
  end
end
