class CreateEventHandlers < ActiveRecord::Migration[5.1]
  def change
    create_table :event_handlers do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
