module ApplicationHelper

  def admin?
    params[:controller].index('admin/') == 0
  end

end
