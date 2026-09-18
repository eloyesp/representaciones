require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  def test_listado_de_reservas_es_un_pdf
    sign_in_as
    get reportes_reservas_path
    assert_response :success
    assert_equal "application/pdf", response.media_type
    assert_includes response.body, "%PDF"
  end

  def test_vouchers_es_un_pdf
    sign_in_as
    get reportes_vouchers_path
    assert_response :success
    assert_equal "application/pdf", response.media_type
    assert_includes response.body, "%PDF"
  end
end