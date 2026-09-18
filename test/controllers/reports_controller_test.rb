require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  def test_listado_de_reservas_es_un_pdf
    sign_in_as
    get reportes_reservas_path, params: { operadora_id: entidads(:costa).id }
    assert_response :success
    assert_equal "application/pdf", response.media_type
    assert_includes response.body, "%PDF"
  end

  def test_vouchers_es_un_pdf
    sign_in_as
    get reportes_vouchers_path, params: { operadora_id: entidads(:costa).id }
    assert_response :success
    assert_equal "application/pdf", response.media_type
    assert_includes response.body, "%PDF"
  end

  def test_reporte_con_mas_del_maximo_errorea
    sign_in_as
    ReportsController.send(:remove_const, :MAX_REPORT_ROWS)
    ReportsController.const_set(:MAX_REPORT_ROWS, 5)
    begin
      6.times do
        Reserva.create!(salida: Date.today,
                        thabitacion: thabitacions(:cuadruple),
                        programa: programas(:punta_del_este),
                        operadora: entidads(:costa),
                        agency: entidads(:litoraltur),
                        total: Money.new(100, "USD"))
      end

      get reportes_reservas_path
      assert_redirected_to reservas_path
      assert_match "más de 5 reservas", flash[:alert]

      get reportes_vouchers_path
      assert_redirected_to reservas_path
    ensure
      ReportsController.send(:remove_const, :MAX_REPORT_ROWS)
      ReportsController.const_set(:MAX_REPORT_ROWS, 500)
    end
  end
end