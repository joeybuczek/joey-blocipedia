class CollaboratorsController < ApplicationController
  
  def create
    # Check to make sure that the user exists, is not already a collaborator, and is not the owner of the wiki.
    if verify_user_to_add
      # Verified, create the collaborator instance
      @collaborator = Collaborator.new(collaborator_params)
      @collaborator.user = user_to_add
      if @collaborator.save
        continue_editing_wiki
      else
        flash[:error] = "There was an error saving these changes. Please try again."
        continue_editing_wiki
      end
      
    else
      # Not verified, display error message
      flash[:alert] = "This user either cannot be found or is already a collaborator. Please choose another user."
      continue_editing_wiki
    end
  end
  
  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki
    
    @collaborator.destroy
    redirect_to edit_wiki_path(@wiki)
  end
  
  private
  
  def name_to_use
    params[:collaborator][:name]
  end
  
  def user_to_add
    User.find_by_name(name_to_use)
  end
  
  def collaborator_params
    params[:collaborator].permit(:wiki_id, :name)
  end

  def wiki_being_edited
    Wiki.find(params[:collaborator][:wiki_id])
  end
  
  def continue_editing_wiki
    redirect_to edit_wiki_path(wiki_being_edited)
  end
  
  def verify_user_to_add
    # User must exist && user cannot be the owner && user cannot already be a collaborator
    (user_to_add.nil? == false) && ((wiki_being_edited.user == user_to_add) == false) && ((wiki_being_edited.collaborators.where( name: name_to_use ).count > 0) == false)
  end

end