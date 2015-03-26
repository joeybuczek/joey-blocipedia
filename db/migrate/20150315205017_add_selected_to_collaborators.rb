class AddSelectedToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :selected, :boolean
  end
end
