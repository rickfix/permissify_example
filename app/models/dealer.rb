class Dealer < ActiveRecord::Base
 
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :corporations, :dependent => :destroy
  has_many :brands, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  def dealer; self; end
  def dealer=(d); self; end
  def dealers; [self]; end
  def corporation; nil; end
  def corporation=(c); nil; end
  def brand; nil; end
  def brand=(b); nil; end
  def merchant; nil; end
  def parent; nil; end

end
