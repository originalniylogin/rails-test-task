require 'test_helper'

class AdminsLoginTest < ActionDispatch::IntegrationTest
  def setup
    @admin = admins(:overlord)
  end

  test 'login with invalid information' do
    get admin_login_path
    assert_template 'admin/sessions/new'
    post admin_login_path, params: { session: { email: '', password: '' } }
    assert_template 'admin/sessions/new'
    assert !flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get admin_login_path
    post admin_login_path, params: { session: { login: 'admin', password: 'admin' } }

    assert admin_logged_in?
    assert_redirected_to admin_events_path
    follow_redirect!

    assert_template 'admin/events/index'
    assert_select 'a[href=?]', admin_logout_path

    delete admin_logout_path

    assert !admin_logged_in?
    assert_redirected_to root_path
    follow_redirect!

    assert_select 'a[href=?]', admin_logout_path, count: 0
  end
end
