module ApplicationHelper
  
  def bold_if_current_user(user)
    # Set username to bold text (css class) in the collaborators section for the current user
    if current_user.name == user.name
      'highlight-name'
    end
  end
  
end