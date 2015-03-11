class MembershipsController < ApplicationController
  
  def downgrade
    @user = current_user
    @user.set_role('standard')
    
    if @user.save
      private_to_public
      flash[:notice] = "You account has been successfully downgraded. All of your private wikis are now public."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was a error processing the account. Please try again."
      redirect_to edit_user_registration_path
    end
  end
  
  # Set all private wikis for current user to public after downgrading account from premium to standard
  def private_to_public
    @user = current_user
    @user.wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end
  end
  
end