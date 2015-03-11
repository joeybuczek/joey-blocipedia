class Wiki < ActiveRecord::Base
  belongs_to :user
  
  scope :visible_to, -> (user) { (user.role == 'premium') || (user.role == 'admin') ? all : where(private: false) }
  
end
