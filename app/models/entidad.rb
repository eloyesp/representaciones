# -*- coding: utf-8 -*-
class Entidad < ActiveRecord::Base
  # clases
  acts_as_versioned

  # asociaciones
  belongs_to :user #es el usuario que lo crea o modifica
  belongs_to :localidad
  has_many :cuentas, :dependent => :destroy  #cuando se borra la entidad se borra la cuenta.
  has_many :movimientos
  has_many :pagos

  attr_accessible :type, :name, :cuit, :localidad_id,
                  :calle, :legajo, :telefono, :web, :email

  #validaciones
  validates :name, :presence => true, :uniqueness => true
  #validates :calle, :presence => true
  #validates :cuit, :presence => true
  #validates :telefono, :presence => true
  #validates :legajo, :presence => true
  #validates :email, :presence => true
  #validates :web, :presence => true
  #validates :localidad_id, :presence => true

  #scopes
  default_scope order(:name)

  scope :baja, where(:hidden=>0)

  # metodos

  # Consulta la cuenta de una entidad en la moneda especificada.
  #
  # @param  [#to_currency] moneda de la cuenta buscada.
  # @param  [Integer] operadora_id id de la operadora que dispone del dinero.
  # @return [Cuenta, nil]

  def cuenta(moneda, operadora_id = nil)
    moneda = Money::Currency.new(moneda).to_s
    cuentas.find_by_monto_currency_and_operadora_id(moneda, operadora_id)
  end

  # Incrementa la cuenta de la entidad segun un monto.
  # Si la cuenta no existe es creada.
  #
  # @param  [#to_money] moneda Moneda de la cuenta buscada.
  # @param  [Operadora] operadora_id operadora que dispone del dinero.
  # @return [Bool]

  def deposit(money, operadora = nil)
    money = money.to_money
    moneda = money.currency_as_string
    # permite que el metodo acepte tanto operadora como id.
    unless operadora.nil?
      operadora = operadora.id unless operadora.kind_of? Integer
    end
   s = Cuenta.find_or_initialize_by_entidad_id_and_monto_currency_and_operadora_id( \
      id, moneda, operadora, {:monto_cents => 0})
    s.monto += money
    s.save
  end

  # Sustrae un monto de la cuenta de la entidad.
  # Si el saldo es insuficiente, da un error.
  #
  # @param  [Money, #to_money] monto Cantidad a sustraer.
  # @param  [Integer] operadora_id id de la operadora que dispone del dinero.
  # @return [Bool]
  # @raise  ["saldo insuficiente"]

  def withdraw(monto, operadora_id = nil)
    monto = monto.to_money
    moneda = monto.currency_as_string
    c = cuenta(moneda, operadora_id)
    c && c.monto >= monto && deposit(monto * -1, operadora_id)
  end

  # Consulta las deudas de la entidad en cada reserva.
  #
  # @return [Array] Un array de deudas de la entidad sin monedas repetidas,
  #   ya que las deudas con la misma moneda son sumadas.

  def deudas
    deudas = reservas.map do |reserva|
      reserva.send((type.downcase + "_deuda").to_sym)
    end
    deudas.reduce([]) do |memo, deuda|
      deuda_currency = deuda.currency
      coincidencia = memo.find_index { |mem| deuda_currency == mem.currency }
      if coincidencia
        memo[coincidencia] = memo[coincidencia] + deuda
      else
        memo << deuda
      end
      memo
    end
  end
end

