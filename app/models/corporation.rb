class Corporation < ActiveRecord::Base

  include PermissifiedProductsInterface::Corporation
  has_and_belongs_to_many :products, :order => "name ASC"
  
  belongs_to :dealer
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :brands, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  def corporation; self; end
  def corporations; [self]; end
  def corporation=(c); self; end
  def brand; nil; end
  def brand=(b); self; end
  def merchant; nil; end
  def parent; self.dealer; end
  
end
