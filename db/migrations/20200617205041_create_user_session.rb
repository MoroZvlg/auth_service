Sequel.migration do
  up do
    create_table :user_sessions do
      column :uuid, 'uuid', primary_key: true
      foreign_key :user_id, :users, null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:user_id], name: :index_user_sessions_on_user_id
      index [:uuid], name: :index_user_sessions_on_uuid
    end
  end

  down do
    drop_table :user_sessions
  end
end