class AddImageToEvents < ActiveRecord::Migration[5.1]
  def change
    add_attachment :events, :image
  end
end
