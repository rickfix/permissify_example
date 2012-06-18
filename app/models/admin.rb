class Admin < ActiveRecord::Base
 
  has_many :users, :as => :entity, :dependent => :destroy
  # has_many :corporations, :dependent => :destroy
  # has_many :brands, :dependent => :destroy
  # has_many :merchants, :dependent => :destroy
  
  def admins; [self]; end
  def dealer; nil; end
  def dealers; Dealer.all; end
  def corporation; nil; end
  def corporations; Corporation.all; end
  def brand; nil; end
  def brands; Brand.all; end
  def merchants; Merchant.all; end
  def merchant; nil; end
  
  def parent; nil; end

end
