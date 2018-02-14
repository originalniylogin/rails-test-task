class AddIndexToAdminsLogin < ActiveRecord::Migration[5.1]
  def change
    add_index :admins, :login, unique: true
  end
end
