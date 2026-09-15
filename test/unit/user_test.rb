require 'test_helper'

# Auth is built from scratch in the new app; pin the role helpers.
class UserTest < ActiveSupport::TestCase

  def test_role_devuelve_los_nombres_de_los_roles
    assert_equal ["Admin"], users(:susana).role
    assert_equal ["Tablas"], users(:tester).role
  end

  def test_role_symbols
    assert_equal [:admin], users(:susana).role_symbols
    assert_equal [:tablas], users(:tester).role_symbols
  end

  def test_role_booleano
    assert users(:susana).role?("Admin")
    refute users(:susana).role?("Pagos")
  end

  def test_user_sin_roles
    user = User.new
    assert_equal [], user.role
    assert_equal [], user.role_symbols
    refute user.role?("Admin")
  end
end