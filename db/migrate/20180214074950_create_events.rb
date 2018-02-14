class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :location
      t.string :name
      t.text :description
      t.string :url
      t.references :event_handler, foreign_key: true
      t.datetime :starts_at

      t.timestamps
    end
  end
end
