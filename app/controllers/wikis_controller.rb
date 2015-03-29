class WikisController < ApplicationController
  # Enable will_paginate to work with database queries as well as static arrays (the return of policy_scope(Wiki) below)
  require 'will_paginate/array'
  
  def index
    if current_user 
      # current user exists, apply policy scope for viewing wikis
      @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
      # @wikis = Wiki.where( user: current_user ).paginate(page: params[:page], per_page: 10)
    else
      # no user exists, supply one for viewing non-private wikis
      @user = User.new(role: 'standard')
      @wikis = Wiki.visible_to(@user).paginate(page: params[:page], per_page: 10)
      authorize @wikis
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
    
  rescue
    # If the wiki doesn't exist...
    flash[:alert] = "Sorry... either you don't have permission to view that wiki, or it doesn't exist."
    redirect_to root_path    
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user = current_user
    @wiki.update_attributes(updated_by: current_user.name)
    # set default privacy setting to false to account for standard users
    if @wiki.private.nil? then @wiki.private = false end
    authorize @wiki
    
    if @wiki.save
      # flash[:notice] = save_message
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @collaborators = Collaborator.all
    @collaborator = Collaborator.new
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)
    @wiki.update_attributes(updated_by: current_user.name)
    authorize @wiki
    
    if @wiki.save
      # flash[:notice] = save_message
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating your wiki."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\'#{title}\' deleted."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end
    
  def transfer_owner
    # transfer ownership to a collaborator
    # set vars
    wiki_to_update = Wiki.find(params.require(:wiki))
    collaborator_to_remove = Collaborator.find(params.require(:collaborator))
    new_owner = User.find_by_name( collaborator_to_remove.name )
    
    # the new owner of the wiki must be a premium account member or an admin
    if new_owner.premium? || new_owner.admin?
      # set new owner
      wiki_to_update.update_attributes(user: new_owner)

      # create new collaborator with previous owner
      @collaborator = Collaborator.new(wiki_id: wiki_to_update.id, name: current_user.name, user: current_user)
      @collaborator.save

      # remove old collaborator
      collaborator_to_remove.destroy

      # let the user know xfer completed
      flash[:notice] = "Ownership transferred to #{new_owner.name}. You are now set as a collaborator."
    else
      # alert as to why cannot xfer ownership
      flash[:alert] = "Cannot transfer ownership to #{new_owner.name}. Only Premium Account members can take ownership of private wikis."
    end
    redirect_to edit_wiki_path(wiki_to_update)
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :subtitle, :body, :private)
  end
    
  def save_message
    @wiki.private == true ? 'Wiki saved as private.' : 'Wiki saved!'
  end
  
end
