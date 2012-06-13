class Corporation < ActiveRecord::Base
 
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :brands, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  def corporation; self; end
  def brand; nil; end
  def parent; self.dealer; end
  
end
