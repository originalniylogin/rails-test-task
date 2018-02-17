class AddIndexToSubscribersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :subscribers, :email, unique: true
  end
end
