class Dealer < ActiveRecord::Base

  include PermissifiedProductsInterface::Dealer
  has_and_belongs_to_many :products, :order => "name ASC"
  
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
  def children; self.corporations; end
  def ancestors; []; end

end
