require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def setup
    @admin = Admin.new(login: 'example', password: 'example')
  end

  test 'should be valid' do
    assert @admin.valid?
  end

  test 'login should be present' do
    @admin.login = '     '
    assert !@admin.valid?
  end

  test 'login should not be too long' do
    @admin.login = 'a' * 33
    assert !@admin.valid?
  end

  test 'login should be unique' do
    duplicate = @admin.dup
    @admin.save
    assert !duplicate.valid?
  end

  test 'password should be present' do
    @admin.password = ' ' * 6
    assert !@admin.valid?
  end

end
