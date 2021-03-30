class RemoveImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image_id, :string
    remove_column :users, :image, :string
    remove_column :users, :image_iprofile_image_id, :string
    add_column :users, :profile_image_id, :string
  end
end
