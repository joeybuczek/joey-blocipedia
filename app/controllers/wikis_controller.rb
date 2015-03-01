class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    
    if @wiki.save
      flash[:notice] = "New wiki saved!"
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki saved!"
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating your wiki."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    
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
    params.require(:wiki).permit(:title, :subtitle, :body)
  end
  
end
