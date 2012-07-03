class Admin < ActiveRecord::Base

  include PermissifiedProductsInterface::Admin
  has_and_belongs_to_many :products, :order => "name ASC"
   
  has_many :users, :as => :entity, :dependent => :destroy
  
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
