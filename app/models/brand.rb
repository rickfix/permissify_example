class Brand < ActiveRecord::Base
 
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  def brand; self; end
  def parent; self.corporation; end
  
end
