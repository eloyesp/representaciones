module ReservasHelper
  def estado_reserva(reserva)
    if reserva.sin_tarifa?
      "Sin tarifa"
    elsif reserva.liquidada?
      "Liquidada"
    else
      "Pendiente"
    end
  end
end