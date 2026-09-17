class ReservasController < ApplicationController
  def index
    scope = Reserva.baja.with_includes
    scope = scope.where(operadora_id: params[:operadora_id]) if params[:operadora_id].present?
    scope = scope.where(agency_id: params[:agency_id]) if params[:agency_id].present?
    scope = scope.where("referencia ILIKE ?", "%#{params[:referencia].strip}%") if params[:referencia].present?
    @pagy, @reservas = pagy(scope)
  end

  def show
    @reserva = Reserva.with_includes.find(params[:id])
  end
end