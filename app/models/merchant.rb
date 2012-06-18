class Merchant < ActiveRecord::Base
  
  belongs_to :dealer
  belongs_to :corporation
  belongs_to :brand
  has_many :users, :as => :entity, :dependent => :destroy

  def merchant; self; end
  def merchants; [self]; end
  def parent; self.brand; end

end
