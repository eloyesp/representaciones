class User < ActiveRecord::Base

  # M4 (basico): reemplazo de devise por has_secure_password.
  has_secure_password

  validates :username, presence: true, uniqueness: true

  has_many :permitions
  has_many :roles ,:through => :permitions

  def role
    roles.map(&:name)
  end

  def role?(rol)
    role.include?(rol)
  end

  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
end