# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_18_100000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at"
    t.string "title"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at"
    t.boolean "open"
    t.datetime "updated_at"
  end

  create_table "cotizacions", force: :cascade do |t|
    t.float "compra"
    t.datetime "created_at"
    t.date "fecha"
    t.string "moneda_compra", limit: 3
    t.string "moneda_venta", limit: 3
    t.datetime "updated_at"
    t.float "venta"
  end

  create_table "cuentas", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "entidad_id"
    t.integer "moneda_id"
    t.integer "monto_cents"
    t.string "monto_currency", limit: 3
    t.integer "operadora_id"
    t.datetime "updated_at"
  end

  create_table "departamentos", force: :cascade do |t|
    t.datetime "created_at"
    t.string "name"
    t.integer "provincia_id"
    t.datetime "updated_at"
  end

  create_table "entidad_versions", force: :cascade do |t|
    t.string "calle"
    t.datetime "created_at"
    t.string "cuit"
    t.string "email"
    t.integer "entidad_id"
    t.boolean "hidden", default: false
    t.string "legajo"
    t.integer "localidad_id"
    t.string "name"
    t.string "telefono"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.string "versioned_type"
    t.string "web"
    t.index ["entidad_id"], name: "index_entidad_versions_on_entidad_id"
  end

  create_table "entidads", force: :cascade do |t|
    t.string "calle"
    t.datetime "created_at"
    t.string "cuit"
    t.string "email"
    t.boolean "hidden", default: false
    t.string "legajo"
    t.integer "localidad_id"
    t.string "name"
    t.string "telefono"
    t.string "type"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.string "web"
  end

  create_table "localidads", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "departamento_id"
    t.string "name"
    t.datetime "updated_at"
  end

  create_table "moneda_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.integer "moneda_id"
    t.string "name"
    t.string "simbolo"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["moneda_id"], name: "index_moneda_versions_on_moneda_id"
  end

  create_table "monedas", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.string "simbolo"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "montos", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "moneda_id"
    t.datetime "updated_at"
    t.float "valor"
  end

  create_table "movimiento_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "entidad_id"
    t.date "fecha"
    t.boolean "hidden", default: false
    t.integer "monto_id"
    t.integer "movimiento_id"
    t.integer "numero"
    t.integer "reserva_id"
    t.integer "saldo_id"
    t.integer "tdeposito_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.string "versioned_type"
    t.index ["movimiento_id"], name: "index_movimiento_versions_on_movimiento_id"
  end

  create_table "movimientos", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "cuenta_id"
    t.integer "entidad_id"
    t.date "fecha"
    t.boolean "hidden", default: false
    t.integer "monto_cents"
    t.string "monto_currency", limit: 3
    t.integer "monto_final_cents"
    t.string "monto_final_currency", limit: 3
    t.integer "monto_id"
    t.integer "movimiento_id"
    t.string "numero"
    t.string "observaciones"
    t.integer "operadora_id"
    t.integer "operation_id"
    t.integer "reserva_id"
    t.integer "tdeposito_id"
    t.string "type"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["entidad_id"], name: "index_movimientos_on_entidad_id"
    t.index ["operation_id"], name: "index_movimientos_on_operation_id"
    t.index ["reserva_id"], name: "index_movimientos_on_reserva_id"
    t.index ["type"], name: "index_movimientos_on_type"
  end

  create_table "operations", force: :cascade do |t|
    t.datetime "created_at"
    t.date "date"
    t.string "type"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["date"], name: "index_operations_on_date"
    t.index ["type"], name: "index_operations_on_type"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at"
    t.string "menu"
    t.string "title"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "pasajero_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "doc"
    t.boolean "hidden", default: false
    t.date "nacimiento"
    t.string "name"
    t.integer "pasajero_id"
    t.integer "tdoc_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["pasajero_id"], name: "index_pasajero_versions_on_pasajero_id"
  end

  create_table "pasajeros", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "doc"
    t.boolean "hidden", default: false
    t.date "nacimiento"
    t.string "name"
    t.integer "tdoc_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "permitions", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.integer "role_id"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.integer "comment_id"
    t.datetime "created_at"
    t.string "name"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "programa_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.text "obs"
    t.integer "programa_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["programa_id"], name: "index_programa_versions_on_programa_id"
  end

  create_table "programas", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.text "obs"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "provincias", force: :cascade do |t|
    t.datetime "created_at"
    t.string "name"
    t.datetime "updated_at"
  end

  create_table "reserva_versions", force: :cascade do |t|
    t.boolean "activa", default: false
    t.float "aereo"
    t.integer "aereo_cents"
    t.integer "agency_id"
    t.boolean "cancelada", default: false
    t.integer "comision"
    t.datetime "created_at"
    t.float "float"
    t.integer "habitaciones"
    t.boolean "hidden", default: false
    t.text "hotel"
    t.float "impuesto"
    t.integer "impuesto_cents"
    t.float "iva"
    t.integer "iva_cents"
    t.boolean "liquido_agencia", default: false
    t.boolean "liquido_operadora", default: false
    t.integer "monto_id"
    t.text "obs"
    t.string "operado"
    t.integer "operadora_id"
    t.float "otros"
    t.integer "otros_cents"
    t.float "pago_minimo"
    t.integer "pago_minimo_cents"
    t.string "periodo"
    t.integer "programa_id"
    t.string "referencia"
    t.string "regimen"
    t.integer "reserva_id"
    t.string "reserva_versionscol", limit: 45
    t.string "reservado"
    t.date "salida"
    t.float "seguro"
    t.integer "seguro_cents"
    t.float "tarifa"
    t.integer "tarifa_cents"
    t.integer "thabitacion_id"
    t.integer "total_cents"
    t.string "total_currency", limit: 3
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.date "voucher"
    t.index ["reserva_id"], name: "index_reserva_versions_on_reserva_id"
  end

  create_table "reservas", force: :cascade do |t|
    t.boolean "activa", default: false
    t.float "aereo"
    t.integer "aereo_cents"
    t.integer "agency_id"
    t.boolean "cancelada", default: false
    t.integer "comision"
    t.datetime "created_at"
    t.float "float"
    t.integer "habitaciones"
    t.boolean "hidden", default: false
    t.text "hotel"
    t.float "impuesto"
    t.integer "impuesto_cents"
    t.float "iva"
    t.integer "iva_cents"
    t.boolean "liquido_agencia", default: false
    t.boolean "liquido_operadora", default: false
    t.integer "monto_id"
    t.text "obs"
    t.string "operado"
    t.integer "operadora_id"
    t.float "otros"
    t.integer "otros_cents"
    t.float "pago_minimo"
    t.integer "pago_minimo_cents"
    t.string "periodo"
    t.integer "programa_id"
    t.string "referencia"
    t.string "regimen"
    t.string "reservado"
    t.date "salida"
    t.float "seguro"
    t.integer "seguro_cents"
    t.float "tarifa"
    t.integer "tarifa_cents"
    t.integer "thabitacion_id"
    t.integer "total_cents"
    t.string "total_currency", limit: 3
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.date "voucher"
    t.index ["agency_id"], name: "index_reservas_on_agency_id"
    t.index ["operadora_id"], name: "index_reservas_on_operadora_id"
    t.index ["programa_id"], name: "index_reservas_on_programa_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at"
    t.text "desc"
    t.string "name"
    t.datetime "updated_at"
  end

  create_table "sites", force: :cascade do |t|
    t.datetime "created_at"
    t.string "email"
    t.text "footer"
    t.string "icon_content_type"
    t.string "icon_file_name"
    t.integer "icon_file_size"
    t.datetime "icon_updated_at"
    t.string "logo_content_type"
    t.string "logo_file_name"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.text "mision"
    t.string "name"
    t.string "slogan"
    t.string "style"
    t.datetime "updated_at"
  end

  create_table "tdeposito_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.integer "tdeposito_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["tdeposito_id"], name: "index_tdeposito_versions_on_tdeposito_id"
  end

  create_table "tdepositos", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "tdoc_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.integer "tdoc_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["tdoc_id"], name: "index_tdoc_versions_on_tdoc_id"
  end

  create_table "tdocs", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "thabitacion_versions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.integer "thabitacion_id"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
    t.index ["thabitacion_id"], name: "index_thabitacion_versions_on_thabitacion_id"
  end

  create_table "thabitacions", force: :cascade do |t|
    t.datetime "created_at"
    t.boolean "hidden", default: false
    t.string "name"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "version"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "password_digest"
    t.string "password_salt"
    t.datetime "remember_created_at"
    t.string "remember_token"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0
    t.datetime "updated_at"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "viajeros", id: false, force: :cascade do |t|
    t.integer "pasajero_id"
    t.integer "reserva_id"
  end
end
