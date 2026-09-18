require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  def test_unauthenticated_is_redirected_to_login
    get reservas_path
    assert_redirected_to login_path
  end

  def test_login_page_renders
    get login_path
    assert_response :success
    assert_select "h1", "Iniciar sesión"
  end

  def test_login_with_valid_credentials
    post login_path, params: { session: { username: "user", password: "password" } }
    assert_redirected_to root_path

    get root_path
    assert_response :success
  end

  def test_login_with_wrong_password_rerenders_form
    post login_path, params: { session: { username: "user", password: "incorrecta" } }
    assert_response :unprocessable_entity
    assert_match "Usuario o contraseña incorrectos", response.body
  end

  def test_logout_redirects_to_login
    sign_in_as
    delete logout_path
    assert_redirected_to login_path

    get reservas_path
    assert_redirected_to login_path
  end
end