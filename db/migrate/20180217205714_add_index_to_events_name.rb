class AddIndexToEventsName < ActiveRecord::Migration[5.1]
  def change
    add_index :events, :name, unique: true
  end
end
