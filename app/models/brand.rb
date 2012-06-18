class Brand < ActiveRecord::Base
 
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
