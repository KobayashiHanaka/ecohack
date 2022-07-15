class RenamePostColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :post, :post_id
  end
end
