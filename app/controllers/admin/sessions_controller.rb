class Admin::SessionsController < ApplicationController

  include Admin::SessionsHelper

  def new
  end

  def create
    admin = Admin.find_by(login: params[:session][:login])
    if admin && admin.authenticate(params[:session][:password])
      admin_log_in admin
      redirect_to admin_events_path
    else
      flash.now[:danger] = 'Неверный логин или пароль.'
      render 'new'
    end
  end

  def destroy
    admin_log_out
    redirect_to root_path
  end

end
