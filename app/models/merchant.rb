class Merchant < ActiveRecord::Base

  include PermissifiedProductsInterface::Merchant
  has_and_belongs_to_many :products, :order => "name ASC"
  
  belongs_to :dealer
  belongs_to :corporation
  belongs_to :brand
  has_many :users, :as => :entity, :dependent => :destroy

  def merchant; self; end
  def merchants; [self]; end
  def parent; self.brand; end

end
