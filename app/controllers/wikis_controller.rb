class WikisController < ApplicationController
  def index
    # check for current user, if none supply one for viewing non-private wikis
    current_user ? @user = current_user : @user = User.new(role: 'standard')
    @wikis = Wiki.visible_to(@user).paginate(page: params[:page], per_page: 10)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    # set default privacy setting to false to account for standard users
    if @wiki.private.nil? then @wiki.private = false end
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = save_message
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = save_message
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
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :subtitle, :body, :private)
  end
    
    def save_message
    @wiki.private == true ? 'Wiki saved as private.' : 'Wiki saved!'
  end
  
end
