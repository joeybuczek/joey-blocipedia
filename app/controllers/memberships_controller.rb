class MembershipsController < ApplicationController
  
  def downgrade
    
    # 3/14/15 - Incorporate a way to have the user's role set to standard
    #           at the end of a subscription period (end of month, etc)
    
    current_user.update_attributes(:role => 'standard')
    private_to_public
    flash[:notice] = "Your account has been successfully downgraded. All of your private wikis are now public."
    redirect_to edit_user_registration_path
    
  rescue
      flash[:error] = "There was an error processing the account. Please try again."
      redirect_to edit_user_registration_path
  end
  
  # Set all private wikis for current user to public after downgrading 
  # account from premium to standard
  def private_to_public
    current_user.wikis.each do |wiki|
      wiki.update_attributes(:private => false)
    end
  end
  
end