class AddBioToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :bio, :text
  end
end
