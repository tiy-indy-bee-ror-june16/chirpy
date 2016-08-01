class AddPhotoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :photo_id, :string
  end
end
