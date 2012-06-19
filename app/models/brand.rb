class Brand < ActiveRecord::Base

  include PermissifiedProductsInterface::Brand
  has_and_belongs_to_many :products, :order => "name ASC"
  
  belongs_to :dealer
  belongs_to :corporation
  has_many :users, :as => :entity, :dependent => :destroy
  has_many :merchants, :dependent => :destroy
  
  def brand; self; end
  def brand=(b); self; end
  def brands; [self]; end
  def merchant; nil; end
  def parent; self.corporation; end
  
end
