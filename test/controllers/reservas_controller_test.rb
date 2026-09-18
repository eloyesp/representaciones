require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  def test_index_muestra_tabla_de_reservas
    sign_in_as
    get reservas_path
    assert_response :success
    assert_select "table"
  end

  def test_show_muestra_los_datos_de_la_reserva
    sign_in_as
    get reserva_path(reservas(:costa_magica))
    assert_response :success
    assert_match /COSTA MAGICA/, response.body
  end

  def test_index_filtra_por_operadora
    sign_in_as
    get reservas_path, params: { operadora_id: entidads(:costa).id }
    assert_response :success
    assert_match /9331954/, response.body
    assert_no_match /1346266/, response.body
    assert_select 'select#operadora_id option[value=?][selected=selected]', entidads(:costa).id.to_s, 1
  end

  def test_index_filtra_por_referencia
    sign_in_as
    get reservas_path, params: { referencia: "9331954" }
    assert_response :success
    assert_match /9331954/, response.body
    assert_no_match /1346266/, response.body
  end

  def test_index_pagina
    sign_in_as
    20.times do
      Reserva.create!(salida: Date.today,
                      thabitacion: thabitacions(:cuadruple),
                      programa: programas(:punta_del_este),
                      operadora: entidads(:costa),
                      agency: entidads(:litoraltur),
                      total: Money.new(100, "USD"))
    end

    get reservas_path
    assert_response :success
    assert_select "nav.pagy"

    get reservas_path, params: { page: 2 }
    assert_response :success
    assert_select "nav.pagy"
  end

  def test_index_desactiva_reporte_si_hay_muchas_reservas
    sign_in_as
    Reserva.insert_all(
      301.times.map do |i|
        { salida: Date.today, total_cents: 100, total_currency: "USD",
          thabitacion_id: thabitacions(:cuadruple).id,
          programa_id: programas(:punta_del_este).id,
          operadora_id: entidads(:costa).id,
          agency_id: entidads(:litoraltur).id,
          hidden: false, created_at: Time.current, updated_at: Time.current }
      end
    )

    get reservas_path
    assert_response :success
    assert_select "span.disabled", count: 2
    assert_select "a[href^='/reportes/reservas']", count: 0
  end
end