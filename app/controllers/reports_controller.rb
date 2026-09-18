class ReportsController < ApplicationController
  def reservas
    pdf = ReservaReport.new.regular(filtered_scope, params)
    send_data pdf, type: "application/pdf", disposition: "inline", filename: "reservas.pdf"
  end

  def vouchers
    pdf = VoucherReport.new.to_pdf(filtered_scope, "Vouchers")
    send_data pdf, type: "application/pdf", disposition: "inline", filename: "vouchers.pdf"
  end

  private

  def filtered_scope
    scope = Reserva.baja.with_includes
    scope = scope.where(operadora_id: params[:operadora_id]) if params[:operadora_id].present?
    scope = scope.where(agency_id: params[:agency_id]) if params[:agency_id].present?
    scope
  end
end