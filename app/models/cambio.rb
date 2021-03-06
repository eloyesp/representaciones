class Cambio < Movimiento

  validates :cuenta, :presence => true

  before_create :withdraw
  before_create :deposit

  validate :existe_cotizacion?
  validate :saldo_suficiente

  def rate
    if c = cotizacion
      c.add_rate
    end
  end

  #convierte todo lo que halla en la cuenta a la moneda del monto
  def convertir_todo_a(m=cuenta.monto)
     c = cotizacion
     Money.add_rate(m.currency,monto.currency,1/c.compra)
     m.exchange_to(monto.currency)
  end

  def monto_original=(money)
    @monto_original = money
  end

  # valida que exista plata en la cuenta.
  def saldo_suficiente
    if (cuenta && rate && !alcanza_monto_de_la_cuenta?)
       errors.add(:base, "Debe tener suficiente dinero para efectuar el cambio")
    end
  end

  # Indica la cuenta en la que se deposita el monto.
  # @return [Cuenta]
  def cuenta_objetivo
    entidad.cuenta(monto.currency,operadora)
  end

  private
  # La cotización de cuenta a monto
  def cotizacion
    if fecha and monto and cuenta
      Cotizacion.buscar(fecha,cuenta.monto,monto)
    end
  end

  #valida que existe la cotizacion para el día exista.
  def existe_cotizacion?
    monto(true)
    if !cotizacion
      errors.add(:base, "No se cargo la cotizacion para esta transaccion")
    end
  end

  #retiro de la cuenta el monto que voy a cambiar
  def withdraw
    entidad.withdraw(@monto_original || monto.exchange_to(cuenta.monto.currency), operadora)
  end

  #deposito el monto nuevo.
  def deposit
    entidad.deposit(monto, operadora)
  end

  def deshacer
    rate &&
    entidad.withdraw(monto, operadora) &&
    entidad.deposit(monto.exchange_to(cuenta.monto.currency), operadora)
  end

  def alcanza_monto_de_la_cuenta?
    (cuenta.monto - monto).cents >= -9
  end
end

