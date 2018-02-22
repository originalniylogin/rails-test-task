class FixForNullColumns < ActiveRecord::Migration[5.1]
  def change
    change_column_null :events, :name, false
    change_column_null :events, :location, false
    change_column_null :events, :starts_at, false
    change_column_null :events, :event_handler_id, false

    change_column_null :event_handlers, :name, false

    change_column_null :admins, :login, false
    change_column_null :admins, :password_digest, false

    change_column_null :subscribers, :email, false
  end
end
