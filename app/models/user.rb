class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  after_initialize :set_defaults
  
  def set_defaults
    self.role ||= 'standard'
  end
  
  # Roles
  def admin?
    role == 'admin'
  end
  
  def standard?
    role == 'standard'
  end
  
  def premium?
    role == 'premium'
  end
  
  def set_role(role)
    self.role = role
    # Or can use current_user.update_attributes(role: 'role') for immediate changes without using a 'save' method
  end
  
end