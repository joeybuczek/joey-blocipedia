class AddNameToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :name, :string
  end
end
