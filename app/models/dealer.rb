class Dealer < ActiveRecord::Base
 
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :corporations, :dependent => :destroy
  has_many :brands, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  # def dealer; self; end
  def corporation; nil; end
  def brand; nil; end
  
  def parent; nil; end

end
