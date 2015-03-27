class AddUpdatedByToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :updated_by, :string
  end
end
