require 'spec_helper'

describe Deposito do
  it { should validate_presence_of(:tdeposito) }
  it { should validate_presence_of(:numero) }
  it { should validate_presence_of(:entidad) }

  describe '#save' do
    it 'aumenta el saldo en la cuenta de la entidad' do
      pending
      deposito = Factory.build(:deposito)
      deposito.save.should == true
      moneda =Moneda.find(1)
      moneda.id.should >0
      deposito.entidad.cuenta(moneda).should == 5000
    end
  end
end

