Sequel.migration do
  #
  #   create_table "users", force: :cascade do |t|
  #     t.string "name", null: false
  #     t.citext "email", null: false
  #     t.string "password_digest", null: false
  #     t.datetime "created_at", precision: 6, null: false
  #     t.datetime "updated_at", precision: 6, null: false
  #     t.index ["email"], name: "index_users_on_email", unique: true
  #   end
  #
  up do
    create_table :users do
      primary_key :id, type: :Bignum
      column :name, 'character varying', null: false
      column :email, 'character varying', null: false
      column :password_digest, 'character varying', null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:email], name: :index_users_on_email, unique: true
    end
  end

  down do
    drop_table :users
  end


end