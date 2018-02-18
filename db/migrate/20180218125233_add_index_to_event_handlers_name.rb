class AddIndexToEventHandlersName < ActiveRecord::Migration[5.1]
  def change
    add_index :event_handlers, :name, unique: true
  end
end
