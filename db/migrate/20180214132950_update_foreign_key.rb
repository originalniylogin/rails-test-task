class UpdateForeignKey < ActiveRecord::Migration[5.1]
  def change

    remove_foreign_key :events, :event_handlers

    add_foreign_key :events, :event_handlers, on_delete: :cascade

  end
end
