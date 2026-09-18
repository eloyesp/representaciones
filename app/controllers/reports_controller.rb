class ReportsController < ApplicationController
  MAX_REPORT_ROWS = 500 # ~10 páginas para no imprimir pilas de hojas por error

  def reservas
    return unless report_size_ok?
    pdf = ReservaReport.new.regular(filtered_scope, params)
    send_data pdf, type: "application/pdf", disposition: "inline", filename: "reservas.pdf"
  end

  def vouchers
    return unless report_size_ok?
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

  def report_size_ok?
    return true if (params[:operadora_id].present? || params[:agency_id].present?) && filtered_scope.count <= MAX_REPORT_ROWS
    flash[:alert] = "El reporte tiene más de #{MAX_REPORT_ROWS} reservas; refiná los filtros de operadora o agencia."
    redirect_to reservas_path(params.permit(:operadora_id, :agency_id))
    false
  end
end